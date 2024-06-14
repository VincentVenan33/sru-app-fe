// import 'package:flutter/material.dart';

// import '../../shared/spacings.dart';

// class DetailkatalogProduk extends StatefulWidget {
//   const DetailkatalogProduk({super.key});

//   @override
//   State<DetailkatalogProduk> createState() => _DetailkatalogProdukState();
// }

// class _DetailkatalogProdukState extends State<DetailkatalogProduk> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFE1E6E8), // Warna latar belakang AppBar
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Center(
//           child: Text(
//             "Item Detail",
//             style: TextStyle(
//               color: Color(0xFF000000), // Ubah warna teks sesuai kebutuhan
//               fontSize: 17.0,
//               fontStyle: FontStyle.normal,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Image.network(
//                 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Statuarietto_White_Marble_%28Apuan_Marble_Formation%2C_Tertiary_metamorphism_of_Jurassic_limestones%3B_Carrara_region%2C_Italy%29_6_%2840899027645%29.jpg/1200px-Statuarietto_White_Marble_%28Apuan_Marble_Formation%2C_Tertiary_metamorphism_of_Jurassic_limestones%3B_Carrara_region%2C_Italy%29_6_%2840899027645%29.jpg',
//                 width: MediaQuery.of(context).size.width,
//                 height: 230,
//                 fit: BoxFit.cover,
//               ),
//             ],
//           ),
//           Spacings.verSpace(
//             20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 24,
//               right: 24,
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Rosso Alicante Polish',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Spacings.verSpace(
//                           5,
//                         ),
//                         const Text(
//                           'Keramik lantai • Import',
//                           style: TextStyle(
//                             color: Color(
//                               0xFF8F8F8F,
//                             ),
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         )
//                       ],
//                     ),
//                     Container(
//                       width: 46,
//                       height: 46,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFFF6F6F9),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'GM',
//                           style: TextStyle(
//                             color: Color(0xFF7C7C7C),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Spacings.verSpace(
//                   20,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Detail Produk',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacings.verSpace(
//                   16,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'kode',
//                       style: TextStyle(
//                         color: Color(0xFF8F8F8F),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Text(
//                       'BTB-BRI/2207/00016',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   color: Color(0xFFEBEBEB),
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'QR Code',
//                       style: TextStyle(
//                         color: Color(0xFF8F8F8F),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Text(
//                       '1C0000000678',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   color: Color(0xFFEBEBEB),
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Bundle',
//                       style: TextStyle(
//                         color: Color(0xFF8F8F8F),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Text(
//                       '001',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   color: Color(0xFFEBEBEB),
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Slab',
//                       style: TextStyle(
//                         color: Color(0xFF8F8F8F),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Text(
//                       '10',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   color: Color(0xFFEBEBEB),
//                 ),
//                 Spacings.verSpace(
//                   13,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Blok',
//                       style: TextStyle(
//                         color: Color(0xFF8F8F8F),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Text(
//                       '-',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
