import 'package:json_annotation/json_annotation.dart';

part 'get_data_dto.g.dart';

@JsonSerializable()
class GetDataPayload {
  GetDataPayload({
    required this.action,
    required this.filters,
    this.search,
  });

  factory GetDataPayload.fromJson(Map<String, dynamic> json) => _$GetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataPayloadToJson(this);

  final String action;
  final GetFilter filters;
  final List<GetSearch>? search;
}

@JsonSerializable()
class GetFilter {
  GetFilter({
    required this.limit,
    this.page = 1,
    this.sort,
    this.orderby,
    this.nomor,
  });

  factory GetFilter.fromJson(Map<String, dynamic> json) => _$GetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GetFilterToJson(this);

  final int limit;
  final int page;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
  final int? nomor;
}

@JsonSerializable()
class GetSearch {
  GetSearch({
    required this.term,
    this.key,
    this.concat,
    this.query,
  });

  factory GetSearch.fromJson(Map<String, dynamic> json) => _$GetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$GetSearchToJson(this);

  final String term;
  final String? key;
  final int? concat;
  final String? query;
}

@JsonSerializable()
class GetDataResponse {
  GetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory GetDataResponse.fromJson(Map<String, dynamic> json) => _$GetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final GetDataResult data;
}

@JsonSerializable()
class GetDataResult {
  GetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory GetDataResult.fromJson(Map<String, dynamic> json) => _$GetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<GetDataContent> data;
}

@JsonSerializable()
class GetDataContent {
  GetDataContent({
    required this.nomor,
    required this.kode,
    required this.nama,
    this.keterangan = "",
    this.nomormhgelar = 0,
    this.nomormhkota = 0,
    this.nomormhdesa = 0,
    this.nomormhrelasisales = 0,
    this.nomormhtipeoutlet = 0,
    this.nomormhkategoricustomer = 0,
    this.nomormhkelurahan = 0,
    this.nomormhprovinsi = 0,
    this.nomormhkecamatan = 0,
    this.kontak = "",
    this.alamatktp = "",
    this.shareloc = "",
    this.jatuhtempo = 0,
    this.plafon = 0,
    this.npwp = "",
    this.ktp = "",
    this.tanggaleditplafon = "",
    this.alamat = "",
    this.telepon = "",
    this.nohp = "",
    this.hp = "",
    // this.userid = "",
    // this.jenis = 0,
    this.gelar = "",
    this.desa = "",
    this.sales = "",
    this.tipeoutlet = "",
    this.kategoricustomer = "",
    this.kecamatan = "",
    this.kota = "",
    this.provinsi = "",
    this.omset = "",
    this.total = 0,
    this.qty = 0,
  });

  factory GetDataContent.fromJson(Map<String, dynamic> json) => _$GetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataContentToJson(this);

  final int nomor;
  final String kode;
  final String nama;
  final String? keterangan;
  final int? nomormhgelar;
  final int? nomormhkota;
  final int? nomormhdesa;
  @JsonKey(name: 'nomormhrelasi_sales')
  final int? nomormhrelasisales;
  final int? nomormhtipeoutlet;
  final int? nomormhkategoricustomer;
  final int? nomormhkelurahan;
  final int? nomormhprovinsi;
  final int? nomormhkecamatan;
  final String? kontak;
  @JsonKey(name: 'alamat_ktp')
  final String? alamatktp;
  @JsonKey(name: 'share_loc')
  final String? shareloc;
  @JsonKey(name: 'jatuh_tempo')
  final int? jatuhtempo;
  final int? plafon;
  final String? npwp;
  final String? ktp;
  @JsonKey(name: 'tanggal_edit_plafon')
  final String? tanggaleditplafon;
  final String? alamat;
  final String? telepon;
  @JsonKey(name: 'no_hp')
  final String? nohp;
  final String? hp;
  // @JsonKey(name: 'user_id')
  // final String? userid;
  // final int? jenis;
  final String? gelar;
  final String? desa;
  final String? sales;
  final String? tipeoutlet;
  final String? kategoricustomer;
  final String? kecamatan;
  final String? kota;
  final String? provinsi;
  final String? omset;
  final int? total;
  final int? qty;
}
