import 'package:json_annotation/json_annotation.dart';

part 'order_jual_get_data_dto.g.dart';

@JsonSerializable()
class OrderJualGetDataPayload {
  OrderJualGetDataPayload({
    required this.action,
    required this.filters,
    required this.search,
  });

  factory OrderJualGetDataPayload.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataPayloadToJson(this);

  final String action;
  final OrderJualGetFilter filters;
  final List<OrderJualGetSearch> search;
}

@JsonSerializable()
class OrderJualGetFilter {
  OrderJualGetFilter({
    required this.limit,
    required this.page,
    this.sort,
    this.nomor,
    this.orderby,
  });

  factory OrderJualGetFilter.fromJson(Map<String, dynamic> json) => _$OrderJualGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetFilterToJson(this);

  final int limit;
  final int page;
  int? nomor;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
}

@JsonSerializable()
class OrderJualGetSearch {
  OrderJualGetSearch({
    this.term,
    this.key,
    this.query,
  });

  factory OrderJualGetSearch.fromJson(Map<String, dynamic> json) => _$OrderJualGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetSearchToJson(this);

  final String? term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class OrderJualGetDataResponse {
  OrderJualGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory OrderJualGetDataResponse.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final OrderJualGetDataResult data;
}

@JsonSerializable()
class OrderJualGetDataResult {
  OrderJualGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory OrderJualGetDataResult.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<OrderJualGetDataContent> data;
}

@JsonSerializable()
class OrderJualGetDataContent {
  OrderJualGetDataContent({
    this.nomor = 0,
    this.nomordesktop = 0,
    this.nomorthorderjual = 0,
    this.kode = "",
    this.kodebarang = "",
    this.tanggal = "",
    this.transaksitanggal = "",
    this.statusppn = 0,
    this.nomormhrelasicust = 0,
    this.nomorthorderbeli = 0,
    this.nomormhrelasisales = 0,
    this.nomormhbarang = 0,
    this.nomormhsatuan = 0,
    this.kodeext = "",
    this.konversisatuan = "",
    this.selectedsatuan = 1,
    this.keterangan = "",
    this.catatan = "",
    this.nomormhadmin = 0,
    this.nomormhcabang = 0,
    this.subtotal2 = 0,
    this.ppnprosentase = "",
    this.ppnnominal = 0,
    this.total = 0,
    this.sales = "",
    this.customer = "",
    this.diskonprosentase = "",
    this.diskonnominal = 0,
    this.um = 0,
    this.dpp = 0,
    this.totalbiaya = "",
    this.islimitkredit = "",
    this.ishargaminimun = "",
    this.isaging = "",
    this.isnotaopen = "",
    this.ishargamaximun = "",
    this.isdiskonmaximun = "",
    this.qty = 0,
    this.statusapproval = "",
    this.kodecustomer = "",
    this.qtyterdo = "",
    this.netto = 0,
    this.disctotal = 0,
    this.discdirect = 0,
    this.disc3 = 0,
    this.disc2 = 0,
    this.disc1 = 0,
    this.satuanqty = "",
    this.isi = 0,
    this.satuanisi = "",
    this.harga = 0,
    this.subtotal = 0,
    this.maxdisc = "",
    this.barang = "",
    this.satuan = "",
    this.qtyunit = "",
    this.satuanunit = "",
    this.qtyisi = "",
    this.statusdisetujui=0,
    this.statusdelivery="",
  });

  factory OrderJualGetDataContent.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataContentToJson(this);

  final int nomor;
  @JsonKey(name: 'nomor_desktop', includeIfNull: false)
  final int? nomordesktop;
  final int? nomorthorderjual;
  final String kode;
  final String kodebarang;
  final String? tanggal;
  @JsonKey(name: 'transaksi_tanggal')
  final String? transaksitanggal;
  @JsonKey(name: 'status_ppn')
  final int? statusppn;
  @JsonKey(name: 'nomormhrelasi_cust', includeIfNull: false)
  final int? nomormhrelasicust;
  @JsonKey(name: 'nomorthorderbeli', includeIfNull: false)
  final int? nomorthorderbeli;
  @JsonKey(name: 'nomormhrelasi_sales', includeIfNull: false)
  final int? nomormhrelasisales;
  @JsonKey(name: 'kode_ext', includeIfNull: false)
  final String? kodeext;
  @JsonKey(name: 'konversi_satuan', includeIfNull: false)
  final String? konversisatuan;
  @JsonKey(name: 'selected_satuan', includeIfNull: false)
  final int? selectedsatuan;
  final String? keterangan;
  @JsonKey(name: 'catatan', includeIfNull: false)
  final String? catatan;
  final int? nomormhadmin;
  final int? nomormhcabang;
  final int? nomormhbarang;
  final int? nomormhsatuan;
  final int? subtotal2;
  @JsonKey(name: 'ppn_prosentase')
  final String? ppnprosentase;
  @JsonKey(name: 'ppn_nominal')
  final int? ppnnominal;
  final int? total;
  final String? sales;
  final String? customer;
  @JsonKey(name: 'diskon_prosentase')
  final String? diskonprosentase;
  @JsonKey(name: 'diskon_nominal')
  final int? diskonnominal;
  final int? um;
  final int? dpp;
  @JsonKey(name: 'total_biaya')
  final String? totalbiaya;
  @JsonKey(name: 'is_limit_kredit', includeIfNull: false)
  final String? islimitkredit;
  @JsonKey(name: 'is_harga_minimun', includeIfNull: false)
  final String? ishargaminimun;
  @JsonKey(name: 'is_aging', includeIfNull: false)
  final String? isaging;
  @JsonKey(name: 'is_nota_open', includeIfNull: false)
  final String? isnotaopen;
  @JsonKey(name: 'is_harga_maximun', includeIfNull: false)
  final String? ishargamaximun;
  @JsonKey(name: 'is_diskon_maximun', includeIfNull: false)
  final String? isdiskonmaximun;
  final int? qty;
  @JsonKey(name: 'status_approval', includeIfNull: false)
  final String? statusapproval;
  final String? kodecustomer;
  @JsonKey(name: 'qty_terdo', includeIfNull: false)
  final String? qtyterdo;
  final int? netto;
  @JsonKey(name: 'disc_total', includeIfNull: false)
  final int? disctotal;
  @JsonKey(name: 'disc_direct', includeIfNull: false)
  final int? discdirect;
  @JsonKey(name: 'disc_3', includeIfNull: false)
  final int? disc3;
  @JsonKey(name: 'disc_2', includeIfNull: false)
  final int? disc2;
  @JsonKey(name: 'disc_1', includeIfNull: false)
  final int? disc1;
  @JsonKey(name: 'satuan_qty', includeIfNull: false)
  final String? satuanqty;
  final int? isi;
  @JsonKey(name: 'satuan_isi', includeIfNull: false)
  final String? satuanisi;
  final int? harga;
  final int? subtotal;
  @JsonKey(name: 'max_disc', includeIfNull: false)
  final String? maxdisc;
  final String? barang;
  final String? satuan;
  @JsonKey(name: 'qty_unit', includeIfNull: false)
  final String? qtyunit;
  @JsonKey(name: 'satuan_unit', includeIfNull: false)
  final String? satuanunit;
  @JsonKey(name: 'qty_isi', includeIfNull: false)
  final String? qtyisi;
  @JsonKey(name: 'status_disetujui', includeIfNull: false)
  final int? statusdisetujui;
  @JsonKey(name: 'status_delivery', includeIfNull: false)
  final String? statusdelivery;
}
