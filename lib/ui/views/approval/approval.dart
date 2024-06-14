import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/networks/order_jual_get_data_dto_network.dart';
import 'package:sru/core/view_models/approval/approval_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';
import 'package:sru/ui/views/approval/detailorder.dart';

import '../../shared/spacings.dart';

class ApprovalView extends ConsumerStatefulWidget {
  const ApprovalView({Key? key}) : super(key: key);

  @override
  ConsumerState<ApprovalView> createState() => _ApprovalViewState();
}

class _ApprovalViewState extends ConsumerState<ApprovalView> {
  @override
  Widget build(BuildContext context) {
    return ViewModel<ApprovalViewModel>(
        model: ApprovalViewModel(
          orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
        ),
        onModelReady: (ApprovalViewModel model) => model.initModel(),
        builder: (_, ApprovalViewModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: UnfocusHelper(
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: sruColor.backgroundAtas,
                    title: const Text(
                      'Daftar Order Jual',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: LazyLoadScrollView(
                          isLoading: model.busy,
                          onEndOfPage: () => model.isLastPage == false ? model.fetchOrderJual() : null,
                          child: RefreshIndicator(
                            onRefresh: () async => model.initModel(),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.orderjual.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24,
                                      left: 24,
                                      right: 24,
                                    ),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      padding: const EdgeInsets.all(0),
                                                      backgroundColor: Color(Colors.transparent.value),
                                                      surfaceTintColor: Colors.white,
                                                      shadowColor: const Color(0x00000000),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(0),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        Routes.approvaldetailorder,
                                                        arguments: ApprovalDetailOrderParam(
                                                          nomor: model.orderjual[index].nomor,
                                                          mode: 'view',
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  width: 120,
                                                                  height: 25,
                                                                  decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                    color: sruColor.lightBlue006,
                                                                  ),
                                                                  child: Text(
                                                                    model.orderjual[index].kode,
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: sruColor.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacings.verSpace(5),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${model.orderjual[index].customer}',
                                                                  style: const TextStyle(
                                                                    fontSize: 15.376,
                                                                    color: sruColor.black,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacings.verSpace(5),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      const TextSpan(
                                                                        text: 'Sales\n',
                                                                        style: TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: sruColor.lightBlack018,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: '${model.orderjual[index].sales}',
                                                                        style: const TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: sruColor.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Spacings.horSpace(20),
                                                                RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      const TextSpan(
                                                                        text: 'Tanggal\n',
                                                                        style: TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: sruColor.lightBlack018,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: model.orderjual[index].tanggal != null
                                                                            ? DateFormat('dd MMMM yyyy').format(
                                                                                DateTime.tryParse(model
                                                                                        .orderjual[index].tanggal!) ??
                                                                                    DateTime.now(),
                                                                              )
                                                                            : '', // Jika tanggal null atau kosong, tampilkan string kosong
                                                                        style: const TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: sruColor.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Spacings.horSpace(20),
                                                                RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      const TextSpan(
                                                                        text: 'Status\n',
                                                                        style: TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: sruColor.lightBlack018,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: _getStatusText(
                                                                            '${model.orderjual[index].statusapproval}'),
                                                                        style: TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: _getStatusColor(
                                                                              '${model.orderjual[index].statusapproval}'),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.pushNamed(
                                                                  context,
                                                                  Routes.approvaldetailorder,
                                                                  arguments: ApprovalDetailOrderParam(
                                                                    nomor: model.orderjual[index].nomor,
                                                                    mode: 'view',
                                                                  ),
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons.chevron_right,
                                                                size: 30,
                                                                color: sruColor.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(12),
                                            const Divider(
                                              height: 1,
                                              color: sruColor.lightBlack009,
                                            ),
                                            Spacings.verSpace(12),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'Approved':
        return 'Disetujui';
      case 'Pending':
        return 'Menunggu';
      case 'Rejected':
        return 'Ditolak';
      default:
        return '-';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return sruColor.green005;
      case 'Pending':
        return sruColor.yellow001;
      case 'Rejected':
        return sruColor.red004;
      default:
        return sruColor.black;
    }
  }
}
