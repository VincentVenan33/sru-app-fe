import 'package:json_annotation/json_annotation.dart';

part 'kunjungan_get_data_dto.g.dart';

@JsonSerializable()
class KunjunganGetDataPayload {
  KunjunganGetDataPayload({
    required this.action,
    required this.filters,
     required this.search,
  });

  factory KunjunganGetDataPayload.fromJson(Map<String, dynamic> json) => _$KunjunganGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$KunjunganGetDataPayloadToJson(this);

  final String action;
  final KunjunganGetFilter filters;
  final List<KunjunganGetSearch> search;
}

@JsonSerializable()
class KunjunganGetFilter {
  KunjunganGetFilter({
    required this.limit,
    this.page = 1,
    this.sort,
    this.orderby,
    this.nomor,
  });

  factory KunjunganGetFilter.fromJson(Map<String, dynamic> json) => _$KunjunganGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$KunjunganGetFilterToJson(this);

  final int limit;
  final int page;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
  final int? nomor;
}

@JsonSerializable()
class KunjunganGetSearch {
  KunjunganGetSearch({
    required this.term,
    this.key,
    this.query,
  });

  factory KunjunganGetSearch.fromJson(Map<String, dynamic> json) => _$KunjunganGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$KunjunganGetSearchToJson(this);

  final String term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class KunjunganGetDataResponse {
  KunjunganGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory KunjunganGetDataResponse.fromJson(Map<String, dynamic> json) => _$KunjunganGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KunjunganGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final KunjunganGetDataResult data;
}

@JsonSerializable()
class KunjunganGetDataResult {
  KunjunganGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory KunjunganGetDataResult.fromJson(Map<String, dynamic> json) => _$KunjunganGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$KunjunganGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<KunjunganGetDataContent> data;
}

@JsonSerializable()
class KunjunganGetDataContent {
  KunjunganGetDataContent(
      {required this.nomor,
      required this.kode,
      this.nomormhcustomer = 1,
      this.nomormhsales = 1,
      this.tanggal = "",
      this.waktuin = "",
      this.waktucheckin = "",
      this.waktuout = "",
      this.waktucheckout = "",
      this.keterangan = "",
      this.judul = "",
      this.rencana = "",
      this.gambar = "",
      this.latitude = "",
      this.longitude = "",
      this.statuscheckin = 0,
      this.statuscheckout = 0,
      this.catatan = "",
      this.alasanvalidasi = "",
      this.alasanunvalidasi = "",
      this.alamat="",
      this.customer = "",
      this.sales = "",
      this.statuskunjungan = "",
      this.total = 0,
      this.qty = 0});

  factory KunjunganGetDataContent.fromJson(Map<String, dynamic> json) => _$KunjunganGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$KunjunganGetDataContentToJson(this);

  final int nomor;
  final String kode;
  final int? nomormhcustomer;
  final int? nomormhsales;
  final String? tanggal;
  @JsonKey(name: 'waktu_in')
  final String? waktuin;
  @JsonKey(name: 'waktu_check_in')
  final String? waktucheckin;
  @JsonKey(name: 'waktu_out')
  final String? waktuout;
  @JsonKey(name: 'waktu_check_out')
  final String? waktucheckout;
  final String? keterangan;
  final String? judul;
  final String? rencana;
  final String? gambar;
  final String? latitude;
  final String? longitude;
  @JsonKey(name: 'status_check_in')
  final int? statuscheckin;
  @JsonKey(name: 'status_check_out')
  final int? statuscheckout;
  final String? catatan;
  @JsonKey(name: 'alasan_validasi')
  final String? alasanvalidasi;
  @JsonKey(name: 'alasan_unvalidasi')
  final String? alasanunvalidasi;
  final String? alamat;
  final String? customer;
  final String? sales;
  @JsonKey(name: 'status_kunjungan')
  final String? statuskunjungan;
  final int? total;
  final int? qty;
}
