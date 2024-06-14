import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/services/authentication_service.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/profile_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/navbar/navbar_sales_view.dart';

class AkunView extends ConsumerStatefulWidget {
  const AkunView({Key? key}) : super(key: key);

  @override
  ConsumerState<AkunView> createState() => _AkunViewState();
}

class _AkunViewState extends ConsumerState<AkunView> {
  // final TextEditingController _searchController = TextEditingController();

  // void _onSearchTextChanged(String query) {
  //   print("Teks pencarian: $query");
  // }

  // void _navigateToDetailPage() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => const DetailOrderJual(),
  //   ));
  //   // FilterBottom.show(context);
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModel<ProfileModel>(
      model: ProfileModel(
        authenticationService: ref.read(authProvider),
        sharedPreferencesService: ref.read(sharedPrefProvider),
      ),
      onModelReady: (ProfileModel model) => model.initModel(),
      builder: (_, ProfileModel model, __) {
        return UnfocusHelper(
          child: SafeArea(
            child: Scaffold(backgroundColor: MjkColor.white,
              appBar: AppBar(
                backgroundColor: MjkColor.backgroundAtas,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 25,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.navBarSales,
                      (route) => false,
                      arguments: NavbarSalesViewParam(
                        menuIndex: 1,
                        // 1 = Aktifitas Sales
                      ),
                    );
                  },
                ),
                title: const Text(
                  'Video Tutorial',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 132,
                          height: 132,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, // Makes the container circular
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://images.unsplash.com/photo-1638803040283-7a5ffd48dad5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80', // Replace with your image URL
                              fit: BoxFit.cover, // You can choose the BoxFit that suits your needs
                            ),
                          ),
                        ),
                        Spacings.horSpace(30),
                        Expanded(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nama',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MjkColor.navbarUnselectedColor,
                                    ),
                                  ),
                                  Spacings.verSpace(5),
                                  Text(
                                    model.nama ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MjkColor.black,
                                    ),
                                  ),
                                  Spacings.verSpace(15),
                                  const Text(
                                    'Pekerjaan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MjkColor.navbarUnselectedColor,
                                    ),
                                  ),
                                  Spacings.verSpace(5),
                                  Text(
                                    model.admingrup ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MjkColor.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacings.verSpace(50),
                    const Row(
                      children: [
                        Text(
                          'Pengaturan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MjkColor.black,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.ubahpassword,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Color(MjkColor.transparent.value),
                        surfaceTintColor: Colors.white,
                        shadowColor: const Color(0x00000000),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 20,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                        'assets/icons/mdi_password.png',
                                      ),
                                      color: MjkColor.black,
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ubah Password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: MjkColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Divider(
                                height: 1,
                                color: MjkColor.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.videotutorial,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Color(MjkColor.transparent.value),
                        surfaceTintColor: Colors.white,
                        shadowColor: const Color(0x00000000),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 20,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                        'assets/icons/bxs_video.png',
                                      ),
                                      color: MjkColor.black,
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Video Tutorial',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: MjkColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Divider(
                                height: 1,
                                color: MjkColor.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => model.requestLogout(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Color(MjkColor.transparent.value),
                        surfaceTintColor: Colors.white,
                        shadowColor: const Color(0x00000000),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 0,
                                  right: 20,
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                        'assets/icons/ci_log-out.png',
                                      ),
                                      color: MjkColor.black,
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Keluar',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: MjkColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Divider(
                                height: 1,
                                color: MjkColor.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
