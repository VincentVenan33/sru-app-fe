import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/view_models/customer/addcustomer_view_model.dart';
import 'package:mjk_apps/core/view_models/customer/updatecustomer_view_model.dart';
import 'package:mjk_apps/core/view_models/meet/createcheckinout_view_model.dart';
import 'package:mjk_apps/core/view_models/orderjual/addorderjual_view_model.dart';
import 'package:mjk_apps/core/view_models/orderjual/edit/updateorderjual_view_model.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/activityandcustomer.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/addcustomer.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/adddesa.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/customer.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/detailcustomer.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/updatecustomer.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/updatedesa.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/meet/addcheckinout.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/meet/addpelanggan.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/meet/detailpelanggan.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/meet/listpelanggan.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/omset.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/piutang.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/salesactivity/addsalesactivy.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/salesactivity/editsalesactivity.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/salesactivity/salesactivity.dart';
import 'package:mjk_apps/ui/views/akun/profile.dart';
import 'package:mjk_apps/ui/views/akun/ubahpassword.dart';
import 'package:mjk_apps/ui/views/approval/approval.dart';
import 'package:mjk_apps/ui/views/approval/detailorder.dart';
import 'package:mjk_apps/ui/views/authentication/login_view.dart';
import 'package:mjk_apps/ui/views/dashboard_view.dart';
import 'package:mjk_apps/ui/views/navbar/navbar_owner_view.dart';
import 'package:mjk_apps/ui/views/navbar/navbar_sales_view.dart';
import 'package:mjk_apps/ui/views/nofitifikasi/notifikasi.dart';
import 'package:mjk_apps/ui/views/omset.dart';
import 'package:mjk_apps/ui/views/orderjual/additemdetail.dart';
import 'package:mjk_apps/ui/views/orderjual/addorderjual.dart';
import 'package:mjk_apps/ui/views/orderjual/addpelanggan.dart';
import 'package:mjk_apps/ui/views/orderjual/daftarorderjual.dart';
import 'package:mjk_apps/ui/views/orderjual/detailorder.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/editadditemdetail.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/edititemdetail.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/editorderjual.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/editpelanggan.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/editprodukkatalog.dart';
import 'package:mjk_apps/ui/views/orderjual/edititemdetail.dart';
import 'package:mjk_apps/ui/views/orderjual/itemdetail.dart';
import 'package:mjk_apps/ui/views/orderjual/orderjual.dart';
import 'package:mjk_apps/ui/views/orderjual/produkkatalog.dart';
import 'package:mjk_apps/ui/views/pengiriman/daftarpengiriman.dart';
import 'package:mjk_apps/ui/views/pengiriman/detail_barcode_view.dart';
import 'package:mjk_apps/ui/views/pengiriman/trackingpengiriman.dart';
import 'package:mjk_apps/ui/views/piutang.dart';
import 'package:mjk_apps/ui/views/splash_screen_view.dart';
import 'package:mjk_apps/ui/views/videotuorial/videotutorial.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver = RouteObserver<PageRoute<dynamic>>();

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    MaterialPageRoute<T>? buildRoute<T>({
      required Widget Function(BuildContext) builder,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<T>(
        settings: settings,
        builder: builder,
        fullscreenDialog: fullscreenDialog,
      );
    }

    // ignore: unused_local_variable
    bool argsIsInvalid = false;

    switch (settings.name) {
      case Routes.splashScreen:
        return buildRoute(
          builder: (_) => const SplashScreenView(),
        );
      case Routes.navBarOwner:
        return buildRoute(
          builder: (_) => const NavbarOwnerView(),
        );

      case Routes.navBarSales:
        final NavbarSalesViewParam param = settings.arguments is NavbarSalesViewParam
            ? settings.arguments as NavbarSalesViewParam
            : NavbarSalesViewParam();
        return buildRoute(
          builder: (_) => NavbarSalesView(
            param: param,
          ),
        );
      case Routes.dashboard:
        return buildRoute(
          builder: (_) => const DashboardView(),
        );

      case Routes.activitysales:
        return buildRoute(
          builder: (_) => const ActivitySalesView(),
        );

      case Routes.piutang:
        return buildRoute(
          builder: (_) => const PiutangView(),
        );

      case Routes.omset:
        return buildRoute(
          builder: (_) => const OmsetView(),
        );
      case Routes.piutangdashboard:
        return buildRoute(
          builder: (_) => const PiutangDashboardView(),
        );

      case Routes.omsetdashboard:
        return buildRoute(
          builder: (_) => const OmsetDashboardView(),
        );

      case Routes.salesactivity:
        return buildRoute(
          builder: (_) => const SalesActivityView(),
        );

      case Routes.addsalesactivity:
        return buildRoute(
          builder: (_) => const AddSalesActivity(),
        );

      case Routes.editsalesactivity:
        return buildRoute(
          builder: (_) => const EditSalesActivity(),
        );

      case Routes.customer:
        return buildRoute(
          builder: (_) => const CustomerView(),
        );

      case Routes.listpelanggan:
        return buildRoute(
          builder: (_) => const ListPelangganView(),
        );

      case Routes.addcheckinout:
        return buildRoute(
          builder: (_) => const AddCheckInOut(),
        );

      case Routes.addpelangganorderjual:
        return buildRoute(
          builder: (_) => AddPelangganOrderJual(
            viewModel: settings.arguments as AddOrderJualViewModel,
          ),
        );

      case Routes.editpelangganorderjual:
        return buildRoute(
          builder: (_) => EditPelangganOrderJual(
            viewModel: settings.arguments as UpdateOrderJualViewModel,
          ),
        );

      case Routes.addcustomer:
        return buildRoute(
          builder: (_) => const AddCustomer(),
        );

      case Routes.editcustomer:
        UpdateCustomerParam param = const UpdateCustomerParam(mode: 'edit', nomor: 0);
        if (settings.arguments is UpdateCustomerParam) {
          param = settings.arguments as UpdateCustomerParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }
        return buildRoute(
          builder: (_) => UpdateCustomer(
            param: param,
          ),
        );

      case Routes.adddesa:
        return buildRoute(
          builder: (_) => AddDesa(
            viewModel: settings.arguments as AddCustomerViewModel,
          ),
        );
      case Routes.editdesa:
        return buildRoute(
          builder: (_) => UpdateDesa(
            viewModel: settings.arguments as UpdateCustomerViewModel,
          ),
        );

      case Routes.detailcustomer:
        DetailCustomerParam param = const DetailCustomerParam(mode: 'view', nomor: 0);
        if (settings.arguments is DetailCustomerParam) {
          param = settings.arguments as DetailCustomerParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => DetailCustomer(
            param: param,
          ),
        );

      case Routes.detailpelanggan:
        DetailPelangganParam param = const DetailPelangganParam(mode: 'view', nomor: 0);
        if (settings.arguments is DetailPelangganParam) {
          param = settings.arguments as DetailPelangganParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => DetailPelanggan(
            param: param,
          ),
        );

      case Routes.orderjual:
        return buildRoute(
          builder: (_) => const OrderJualView(),
        );
      case Routes.addorderjual:
        return buildRoute(
          builder: (_) => const AddOrderJual(),
        );
      case Routes.editorderjual:
        EditOrderJualParam param = const EditOrderJualParam(mode: 'edit', nomor: 0);
        if (settings.arguments is EditOrderJualParam) {
          param = settings.arguments as EditOrderJualParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }
        return buildRoute(
          builder: (_) => EditOrderJual(
            param: param,
          ),
        );

      case Routes.addpelanggan:
        return buildRoute(
          builder: (_) => AddPelanggan(
            viewModel: settings.arguments as AddCheckInOutViewModel,
          ),
        );

      case Routes.detailorderpenjualan:
        DetailOrderPenjualanParam param = const DetailOrderPenjualanParam(mode: 'view', nomor: 0);
        if (settings.arguments is DetailOrderPenjualanParam) {
          param = settings.arguments as DetailOrderPenjualanParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }
        return buildRoute(
          builder: (_) => DetailOrderPenjualan(
            param: param,
          ),
        );

      case Routes.daftarorderjual:
        return buildRoute(
          builder: (_) => const DaftarOrderJualView(),
        );

      case Routes.daftarpengiriman:
        return buildRoute(
          builder: (_) => const DaftarPengirimanView(),
        );

      case Routes.detailbarcode:
        DetailBarcodeParam param = const DetailBarcodeParam(mode: 'view', nomor: 0);
        if (settings.arguments is DetailBarcodeParam) {
          param = settings.arguments as DetailBarcodeParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => DetailBarcode(
            param: param,
          ),
        );

      case Routes.katalogproduk:
        return buildRoute(
          builder: (_) => const ProdukKatalogView(),
        );

      case Routes.editkatalogproduk:
        final EditProdukKatalogParam param = settings.arguments is EditProdukKatalogParam
            ? settings.arguments as EditProdukKatalogParam
            : const EditProdukKatalogParam();
        return buildRoute(
          builder: (_) => EditProdukKatalogView(
            param: param,
          ),
        );

      case Routes.trackingpengiriman:
        TrackingPengirimanParam param = const TrackingPengirimanParam(mode: 'view', nomor: 0);
        if (settings.arguments is TrackingPengirimanParam) {
          param = settings.arguments as TrackingPengirimanParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => TrackingPengiriman(
            param: param,
          ),
        );

      case Routes.approval:
        return buildRoute(
          builder: (_) => const ApprovalView(),
        );

      case Routes.approvaldetailorder:
        ApprovalDetailOrderParam param = const ApprovalDetailOrderParam(mode: 'view', nomor: 0);
        if (settings.arguments is ApprovalDetailOrderParam) {
          param = settings.arguments as ApprovalDetailOrderParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => ApprovalDetailOrder(
            param: param,
          ),
        );

      case Routes.notifikasi:
        return buildRoute(
          builder: (_) => const NotifikasiView(),
        );

      case Routes.akun:
        return buildRoute(
          builder: (_) => const AkunView(),
        );

      case Routes.ubahpassword:
        return buildRoute(
          builder: (_) => const UbahPasswordView(),
        );

      case Routes.videotutorial:
        return buildRoute(
          builder: (_) => const VideoTutorialView(),
        );

      /// Acount
      // case Routes.profile:
      //   return buildRoute(
      //     builder: (_) => const ProfileView(),
      //   );
      // case Routes.editProfile:
      //   return buildRoute(
      //     builder: (_) => const EditProfileView(),
      //   );
      // case Routes.setting:
      //   return buildRoute(
      //     builder: (_) => const SettingView(),
      //   );
      // case Routes.changePassword:
      //   return buildRoute(
      //     builder: (_) => const ChangePasswordView(),
      //   );
      // case Routes.inputEmail:
      //   return buildRoute(
      //     builder: (_) => const InputEmailView(),
      //   );
      // case Routes.inputAddress:
      //   return buildRoute(
      //     builder: (_) => const InputAddressView(),
      //   );

      // Authentication
      case Routes.login:
        final LoginViewParam param =
            settings.arguments is LoginViewParam ? settings.arguments as LoginViewParam : LoginViewParam();
        return buildRoute(
          builder: (_) => LoginView(
            param: param,
          ),
        );

      case Routes.detailCatalog:
        DetailOrderJualParam param = const DetailOrderJualParam(mode: 'view', nomor: 0);
        if (settings.arguments is DetailOrderJualParam) {
          param = settings.arguments as DetailOrderJualParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => DetailOrderJual(
            param: param,
          ),
        );

      case Routes.addDetailCatalog:
        AddDetailOrderParam param = const AddDetailOrderParam(mode: 'view', nomor: 0);
        if (settings.arguments is AddDetailOrderParam) {
          param = settings.arguments as AddDetailOrderParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => AddDetailOrderJual(
            param: param,
          ),
        );
      case Routes.editaddDetailCatalog:
        final EditAddDetailOrderParam param = settings.arguments is EditAddDetailOrderParam
            ? settings.arguments as EditAddDetailOrderParam
            : const EditAddDetailOrderParam();

        return buildRoute(
          builder: (_) => EditAddDetailOrderJual(
            param: param,
          ),
        );
      case Routes.editDetailCatalog:
        final EditDetailOrderParam param = settings.arguments is EditDetailOrderParam
            ? settings.arguments as EditDetailOrderParam
            : const EditDetailOrderParam();
        return buildRoute(
          builder: (_) => EditDetailOrderJual(
            param: param,
          ),
        );

      // case Routes.editDetailCatalog:
      // // EditDetailOrderParam param = const EditDetailOrderParam(mode: 'view', nomor: 0,);
      // // if (settings.arguments is EditDetailOrderParam) {
      // //   param = settings.arguments as EditDetailOrderParam;
      // // } else {
      // //   argsIsInvalid = true;
      // //   // continue invalidArgs;
      // // }
      // final EditDetailOrderParam param = settings.arguments is EditDetailOrderParam
      //     ? settings.arguments as EditDetailOrderParam
      //     : const EditDetailOrderParam();
      // return buildRoute(
      //   builder: (_) => EditDetailOrderJual(
      //     param: param,
      //   ),
      // );
      case Routes.updateeditDetailCatalog:
        final UpdateEditDetailOrderParam param = settings.arguments is UpdateEditDetailOrderParam
            ? settings.arguments as UpdateEditDetailOrderParam
            : const UpdateEditDetailOrderParam();
        return buildRoute(
          builder: (_) => UpdateEditDetailOrderJual(
            param: param,
          ),
        );

      default:
        return null;
    }
    // ignore: dead_code
    return null;
  }
}
