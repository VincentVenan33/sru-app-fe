import 'package:json_annotation/json_annotation.dart';

part 'dashboard_get_data_dto.g.dart';

@JsonSerializable()
class DashboardGetDataPayload {
  DashboardGetDataPayload({
    required this.action,
    required this.filters,
  });

  factory DashboardGetDataPayload.fromJson(Map<String, dynamic> json) =>
      _$DashboardGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardGetDataPayloadToJson(this);

  final String action;
  final DashboardGetFilter filters;
  
}

@JsonSerializable()
class DashboardGetFilter {
  DashboardGetFilter({
    required this.limit,
     this.sort,
     this.orderby,
  });

  factory DashboardGetFilter.fromJson(Map<String, dynamic> json) =>
      _$DashboardGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardGetFilterToJson(this);

  final int limit;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
}

@JsonSerializable()
class DashboardGetDataResponse {
  DashboardGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory DashboardGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final DashboardGetDataResult data;
}

@JsonSerializable()
class DashboardGetDataResult {
  DashboardGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory DashboardGetDataResult.fromJson(Map<String, dynamic> json) =>
      _$DashboardGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<DashboardGetDataContent> data;
}

@JsonSerializable()
class DashboardGetDataContent {
  DashboardGetDataContent({
    this.nomor = 0,
    this.nomordesktop = 0,
    this.kode = "",
    this.tanggal = "",
    this.transaksitanggal = "",
    this.statusppn = 0,
    this.nomormhcustomer = 0,
    this.nomorthorderbeli = 0,
    this.nomormhsales = 0,
    this.kodeext = "",
    this.konversisatuan = "",
    this.selectedsatuan = "",
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
  });

  factory DashboardGetDataContent.fromJson(Map<String, dynamic> json) =>
      _$DashboardGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardGetDataContentToJson(this);

  final int nomor;
  @JsonKey(name: 'nomor_desktop', includeIfNull: false)
  final int? nomordesktop;
  final String kode;
  final String? tanggal;
  @JsonKey(name: 'transaksi_tanggal')
  final String? transaksitanggal;
  @JsonKey(name: 'status_ppn')
  final int? statusppn;
  final int? nomormhcustomer;
  @JsonKey(name: 'nomorthorderbeli', includeIfNull: false)
  final int? nomorthorderbeli;
  final int? nomormhsales;
  @JsonKey(name: 'kode_ext', includeIfNull: false)
  final String? kodeext;
  @JsonKey(name: 'konversi_satuan', includeIfNull: false)
  final String? konversisatuan;
  @JsonKey(name: 'selected_satuan', includeIfNull: false)
  final String? selectedsatuan;
  final String? keterangan;
  @JsonKey(name: 'catatan', includeIfNull: false)
  final String? catatan;
  final int? nomormhadmin;
  final int? nomormhcabang;
  final double? subtotal2;
  @JsonKey(name: 'ppn_prosentase')
  final String? ppnprosentase;
  @JsonKey(name: 'ppn_nominal')
  final double? ppnnominal;
  final double? total;
  final String? sales;
  final String? customer;
  @JsonKey(name: 'diskon_prosentase')
  final String? diskonprosentase;
  @JsonKey(name: 'diskon_nominal')
  final double? diskonnominal;
  final double? um;
  final double? dpp;
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
}
