import 'package:json_annotation/json_annotation.dart';

part 'produk.g.dart';

@JsonSerializable()
class GetProdukResponse {
  GetProdukResponse({
    required this.code,
    this.message,
    required this.data,
  });

  factory GetProdukResponse.fromJson(Map<String, dynamic> json) => _$GetProdukResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProdukResponseToJson(this);

  final int code;
  final String? message;

  @JsonKey(defaultValue: [])
  final List<Produk> data;
}

@JsonSerializable()
class Produk {
  Produk({
    // required this.nomormhgolonganbarang,
    // required this.nomormhkategoribarang,
    // required this.nomormhsubstitusibarang,
    // required this.nomormhjenispenjualan,
    // required this.nomormhgroupbarang,
    // required this.nomormhsatuan1,
    // required this.nomormhsatuan2,
    // required this.nomormhsatuan3,
    // required this.nomormhsupplier,
    required this.kode,
    required this.nama,
    required this.berat,
    // required this.konversisatuan2,
    // required this.konversisatuan3,
    // required this.kongsi,
    // required this.komisi,
    required this.bonus,
    // required this.maxharga1,
    // required this.maxharga2,
    // required this.maxharga3,
    // required this.minharga1,
    // required this.minharga2,
    // required this.minharga3,
    // required this.maxdisc1,
    // required this.maxdisc2,
    // required this.maxdisc3,
    // required this.hargapricelist,
    // required this.minimumstok,
    // required this.expdate,
    // required this.eod,
    // required this.barcodesatuan1,
    // required this.barcodesatuan2,
    // required this.barcodesatuan3,
    // required this.keterangan,
    // required this.catatan,
    // required this.statusaktif,
    // required this.dibuatoleh,
    // required this.diubaholeh,
    // required this.dihapusoleh,
    // required this.statusdisetujui,
    // required this.disetujuioleh,
    // required this.dibatalkanoleh,
    // required this.statusprint,
    // required this.diprintoleh,
    // required this.statustt,
    // required this.dittoleh,
    required this.golongan,
    // required this.kategori,
    // required this.substitusi,
    required this.jenispenjualan,
    required this.groupbarang,
    required this.satuan,
    this.supplier,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => _$ProdukFromJson(json);

  Map<String, dynamic> toJson() => _$ProdukToJson(this);

  // final int nomormhgolonganbarang;
  // final int nomormhkategoribarang;
  // final int nomormhsubstitusibarang;
  // final int nomormhjenispenjualan;
  // final int nomormhgroupbarang;
  // final int nomormhsatuan1;
  // final int nomormhsatuan2;
  // final int nomormhsatuan3;
  // final int nomormhsupplier;
  final String kode;
  final String nama;
  final String berat;
  // @JsonKey(name: 'konversi_satuan_2')
  // final String konversisatuan2;
  // @JsonKey(name: 'konversi_satuan_3')
  // final String konversisatuan3;
  // // final int kongsi;
  // final int komisi;
  final String bonus;
  // @JsonKey(name: 'max_harga1')
  // final String maxharga1;
  // @JsonKey(name: 'max_harga2')
  // final String maxharga2;
  // @JsonKey(name: 'max_harga3')
  // final String maxharga3;
  // @JsonKey(name: 'min_harga1')
  // final String minharga1;
  // @JsonKey(name: 'min_harga2')
  // final String minharga2;
  // @JsonKey(name: 'min_harga3')
  // final String minharga3;
  // @JsonKey(name: 'max_disc1')
  // final String maxdisc1;
  // @JsonKey(name: 'max_disc2')
  // final String maxdisc2;
  // @JsonKey(name: 'max_disc3')
  // final String maxdisc3;
  // @JsonKey(name: 'harga_pricelist')
  // final String hargapricelist;
  // @JsonKey(name: 'minimum_stok')
  // final int minimumstok;
  // @JsonKey(name: 'exp_date')
  // final String expdate;
  // final String eod;
  // @JsonKey(name: 'barcode_satuan_1')
  // final String barcodesatuan1;
  // @JsonKey(name: 'barcode_satuan_2')
  // final String barcodesatuan2;
  // @JsonKey(name: 'barcode_satuan_3')
  // final String barcodesatuan3;
  // final String keterangan;
  // final String catatan;
  // @JsonKey(name: 'status_aktif')
  // final int statusaktif;
  // @JsonKey(name: 'dibuat_oleh')
  // final int dibuatoleh;
  // @JsonKey(name: 'diubah_oleh')
  // final String diubaholeh;
  // @JsonKey(name: 'dihapus_oleh')
  // final int dihapusoleh;
  // @JsonKey(name: 'status_disetujui')
  // final String statusdisetujui;
  // @JsonKey(name: 'disetujui_oleh')
  // final int disetujuioleh;
  // @JsonKey(name: 'dibatalkan_oleh')
  // final String dibatalkanoleh;
  // @JsonKey(name: 'status_print')
  // final int statusprint;
  // @JsonKey(name: 'diprint_oleh')
  // final int diprintoleh;
  // @JsonKey(name: 'status_tt')
  // final String statustt;
  // @JsonKey(name: 'ditt_oleh')
  // final int dittoleh;
  final String golongan;
  // final String kategori;
  // final String substitusi;
  @JsonKey(name: 'jenis_penjualan')
  final String jenispenjualan;
  @JsonKey(name: 'group_barang')
  final String groupbarang;
  final String satuan;
  final String? supplier;
}
