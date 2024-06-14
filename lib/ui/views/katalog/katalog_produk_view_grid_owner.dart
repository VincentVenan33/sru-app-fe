// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sru/core/networks/produk_network.dart';
// import 'package:sru/core/view_models/view_model.dart';
// import 'package:sru/ui/shared/loading_overlay.dart';
// import 'package:sru/ui/views/katalog/detail_katalog_produk_owner.dart';

// import '../../../core/view_models/produk/daftarprderjual_view_model.dart';
// import '../../shared/spacings.dart';
// import '../../widgets/search_bar.dart' as search;

// class KatalogProdukView extends ConsumerStatefulWidget {
//   const KatalogProdukView({Key? key}) : super(key: key);

//   @override
//   ConsumerState<KatalogProdukView> createState() => _KatalogProdukViewState();
// }

// class _KatalogProdukViewState extends ConsumerState<KatalogProdukView> {
//   final TextEditingController _searchController = TextEditingController();

//   void _onSearchTextChanged(String query) {
//     print("Teks pencarian: $query");
//   }

//   void _navigateToDetailPage() {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => const DetailkatalogProduk(),
//     ));
//     // FilterBottom.show(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LoadingOverlay(
//       // isLoading: model.busy,
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               height: 130,
//               color: const Color(0xFFE1E6E8),
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Katalog Produk',
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     Spacings.verSpace(
//                       10,
//                     ),
//                     search.SearchBar(
//                       controller: _searchController,
//                       hintText: 'Cari produk...',
//                       onChanged: _onSearchTextChanged,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: GridView.builder(
//                 // itemCount: model.produk.length,
//                 // itemCount: 6,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 14.0,
//                   crossAxisSpacing: 14.0,
//                 ),
//                 padding: const EdgeInsets.all(24.0),
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: _navigateToDetailPage,
//                     child: Card(
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(5.0),
//                                     topRight: Radius.circular(5.0),
//                                   ),
//                                   child: Image.network(
//                                     'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Statuarietto_White_Marble_%28Apuan_Marble_Formation%2C_Tertiary_metamorphism_of_Jurassic_limestones%3B_Carrara_region%2C_Italy%29_6_%2840899027645%29.jpg/1200px-Statuarietto_White_Marble_%28Apuan_Marble_Formation%2C_Tertiary_metamorphism_of_Jurassic_limestones%3B_Carrara_region%2C_Italy%29_6_%2840899027645%29.jpg',
//                                     height: 52,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Spacings.verSpace(
//                             12,
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 12,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       // model.produk[index].kode,
//                                       style: const TextStyle(
//                                         fontSize: 8,
//                                       ),
//                                     ),
//                                     Text(
//                                       // '${model.produk[index].nama.substring(0, 8)}...',
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       // model.produk[index].golongan,
//                                       style: const TextStyle(
//                                         fontSize: 8,
//                                       ),
//                                     ),
//                                     Text(
//                                       // '${model.produk[index].groupbarang.substring(0, 8)}...',
//                                       style: const TextStyle(
//                                         fontSize: 8,
//                                       ),
//                                     ),
//                                     Text(
//                                       // model.produk[index].jenispenjualan,
//                                       style: const TextStyle(
//                                         fontSize: 8,
//                                       ),
//                                     ),
//                                     Text(
//                                       // model.produk[index].satuan,
//                                       style: const TextStyle(
//                                         fontSize: 8,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
