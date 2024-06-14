import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';

class HeaderUser extends StatelessWidget {
  const HeaderUser({
    Key? key,
    required this.nama,
    required this.admingrup,
  }) : super(key: key);

  final String nama;
  final String admingrup;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 290,
              decoration: const BoxDecoration(
                color: MjkColor.transparent,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.akun,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: Color(MjkColor.backgroundAtas.value),
                  surfaceTintColor: MjkColor.backgroundAtas,
                  shadowColor: MjkColor.transparent,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.zero,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
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
                    Expanded(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MjkColor.black,
                                ),
                              ),
                              Text(
                                admingrup,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
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
              ),
            ),
            IconButton(
              icon: const ImageIcon(
                AssetImage(
                  'assets/icons/notification-bing.png',
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.notifikasi,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

// class HeaderSales {
//   static Container headSales() => Container(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             children: [
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle, // Makes the container circular
//                 ),
//                 child: ClipOval(
//                   child: Image.network(
//                     'https://images.unsplash.com/photo-1638803040283-7a5ffd48dad5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80', // Replace with your image URL
//                     fit: BoxFit
//                         .cover, // You can choose the BoxFit that suits your needs
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Ajeng Wigati',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Sales Lapangan',
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(
//                     left: 10), // Adjust the margin as needed
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: MjkColor
//                         .iconButtonSalesColor, // Border color for the icon
//                     width: 2.0, // Border width for the icon
//                   ),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.notifications_none_outlined),
//                   color: Colors.black,
//                   onPressed: () {
//                     // Add your notification icon's onPressed functionality here
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
