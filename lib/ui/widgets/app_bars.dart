import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/utilities/text_styles.dart';
import 'package:sru/ui/shared/spacings.dart';

PreferredSizeWidget buildAppBar(
  BuildContext context, {
  String? title,
  VoidCallback? onBackButtonPressed,
  VoidCallback? beforeBackButtonPressed,
  VoidCallback? afterBackButtonPressed,
}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    foregroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 60,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(color: sruColor.lightBlack001, blurRadius: 1.0, offset: Offset(0.0, 0.75))],
        color: Colors.white,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                beforeBackButtonPressed?.call();
                onBackButtonPressed?.call();
                afterBackButtonPressed?.call();
              },
              child: Container(
                padding: const EdgeInsets.only(left: 14),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xff2F455C),
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: buildTextStyle(
                  fontSize: 18,
                  fontWeight: 400,
                  color: Colors.black,
                  fontHeight: 22.27,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
              width: 32,
            )
          ],
        ),
      ),
    ),
  );
}

PreferredSizeWidget buildBasicAppBar(
  BuildContext context, {
  String? title,
  bool anyNotif = false,
  void Function()? onNotificationButtonPressed,
  void Function()? onLogoutButtonPressed,
}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    automaticallyImplyLeading: false,
    backgroundColor: sruColor.lightBlue005,
    foregroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 60,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(color: sruColor.lightBlack001, blurRadius: 1.0, offset: Offset(0.0, 0.75))],
        color: sruColor.lightBlue005,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 70,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/sru.png',
                  ),
                  fit: BoxFit.fitHeight,
                ),
                // color: Colors.white,
              ),
            ),
            Transform.translate(
              offset: const Offset(10, 0),
              child: Text(
                'Maju Jaya Kupang',
                style: buildTextStyle(
                  fontSize: 16,
                  fontWeight: 500,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: buildTextStyle(
                  fontSize: 18,
                  fontWeight: 500,
                  color: Colors.white,
                  fontHeight: 22.27,
                ),
              ),
            ),
            GestureDetector(
              onTap: onNotificationButtonPressed,
              child: anyNotif
                  ? const SizedBox(
                      child: Stack(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage(
                              'assets/icons/notification-bing.png',
                            ),
                            size: 25,
                          ),
                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: Icon(Icons.brightness_1, size: 8.0, color: Colors.redAccent),
                          )
                        ],
                      ),
                    )
                  : const ImageIcon(
                      AssetImage(
                        'assets/icons/notification-bing.png',
                      ),
                    ),
            ),
            Spacings.horSpace(10),
            InkWell(
              onTap: onLogoutButtonPressed,
              child: const ImageIcon(
                AssetImage(
                  'assets/icons/ic_baseline-log-out.png',
                ),
                // size: 25,
              ),
            ),
            const SizedBox(
              height: 60,
              width: 20,
            ),
          ],
        ),
      ),
    ),
  );
}

// PreferredSizeWidget buildBasicAppBar(
//   BuildContext context, {
//   String? title,
//   VoidCallback? onBackButtonPressed,
//   void Function()? onDeleteButtonPressed,
// }) {
//   return AppBar(
//     systemOverlayStyle: SystemUiOverlayStyle.light,
//     automaticallyImplyLeading: false,
//     backgroundColor: Colors.transparent,
//     foregroundColor: Colors.transparent,
//     elevation: 0,
//     toolbarHeight: 80,
//     flexibleSpace: SafeArea(
//       bottom: false,
//       child: Row(
//         children: <Widget>[
//           InkWell(
//             onTap: () {
//               onBackButtonPressed?.call();
//               if (Navigator.canPop(context)) {
//                 Navigator.maybePop(context);
//               } else {
//                 Navigator.pushNamedAndRemoveUntil(
//                   context,
//                   Routes.dashboard,
//                   (Route<dynamic> route) => false,
//                 );
//               }
//             },
//             child: const Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               title ?? '',
//               textAlign: TextAlign.center,
//               style: buildTextStyle(
//                 fontSize: 18,
//                 fontWeight: 500,
//                 color: Colors.white,
//                 fontHeight: 22.27,
//               ),
//             ),
//           ),
//           if (onDeleteButtonPressed != null)
//             InkWell(
//               onTap: onDeleteButtonPressed,
//               child: const SizedBox(
//                 height: 32,
//                 width: 32,
//                 child: Icon(
//                   Icons.delete,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//             )
//           else
//             const SizedBox(
//               height: 32,
//               width: 32,
//             )
//         ],
//       ),
//     ),
//   );
// }

// PreferredSizeWidget buildTransparentAppBar({
//   Color backgroundColor = KonekinColors.lightBlack006,
// }) {
//   return AppBar(
//     systemOverlayStyle: SystemUiOverlayStyle.dark,
//     toolbarHeight: 0,
//     backgroundColor: backgroundColor,
//     elevation: 0,
//   );
// }

// PreferredSizeWidget buildSidebarAppBar(
//   BuildContext context, {
//   required GlobalKey<ScaffoldState> scaffoldKey,
//   required String title,
// }) {
//   return AppBar(
//     systemOverlayStyle: SystemUiOverlayStyle.light,
//     automaticallyImplyLeading: false,
//     backgroundColor: Colors.transparent,
//     foregroundColor: Colors.transparent,
//     elevation: 0,
//     toolbarHeight: 80,
//     flexibleSpace: Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(
//             ImagePaths.appBarTransparentBackground,
//           ),
//           fit: BoxFit.fill,
//         ),
//         color: KonekinColors.black001,
//       ),
//       padding: const EdgeInsets.all(24),
//       child: SafeArea(
//         bottom: false,
//         child: Row(
//           children: <Widget>[
//             InkWell(
//               onTap: () => scaffoldKey.currentState?.openDrawer(),
//               child: const Icon(
//                 Icons.list,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//             Spacings.horSpace(16),
//             Expanded(
//               child: Text(
//                 title,
//                 textAlign: TextAlign.left,
//                 style: buildTextStyle(
//                   fontSize: 18,
//                   fontWeight: 500,
//                   color: Colors.white,
//                   fontHeight: 22.27,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 32,
//               width: 32,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
