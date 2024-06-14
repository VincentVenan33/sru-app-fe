import 'package:json_annotation/json_annotation.dart';

part 'tracking_order_jual_get_data_dto.g.dart';

@JsonSerializable()
class TrackingOrderJualGetDataPayload {
  TrackingOrderJualGetDataPayload({
    required this.action,
    required this.filters,
  });

  factory TrackingOrderJualGetDataPayload.fromJson(Map<String, dynamic> json) =>
      _$TrackingOrderJualGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingOrderJualGetDataPayloadToJson(this);

  final String action;
  final TrackingOrderJualGetFilter filters;
}

@JsonSerializable()
class TrackingOrderJualGetFilter {
  TrackingOrderJualGetFilter({
    this.nomor,
  });

  factory TrackingOrderJualGetFilter.fromJson(Map<String, dynamic> json) => _$TrackingOrderJualGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingOrderJualGetFilterToJson(this);

  final int? nomor;
}

@JsonSerializable()
class TrackingOrderJualGetDataResponse {
  TrackingOrderJualGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory TrackingOrderJualGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackingOrderJualGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingOrderJualGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final TrackingOrderJualGetDataResult data;
}

@JsonSerializable()
class TrackingOrderJualGetDataResult {
  TrackingOrderJualGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory TrackingOrderJualGetDataResult.fromJson(Map<String, dynamic> json) =>
      _$TrackingOrderJualGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingOrderJualGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<TrackingOrderJualGetDataContent> data;
}

@JsonSerializable()
class TrackingOrderJualGetDataContent {
  TrackingOrderJualGetDataContent({
    required this.nomor,
    this.latitudepenerima = "",
    this.longitudepenerima = "",
    this.latitudekirim = "",
    this.longitudekirim = "",
    this.statusoj = 0,
    this.kodeoj = "",
    this.waktuoj = "",
    this.statusdo = 0,
    this.kodedo = "",
    this.waktudo = "",
    this.statussj = 0,
    this.kodesj = "",
    this.waktusj = "",
    this.statusberangkat = 0,
    this.waktuberangkat = "",
    this.latitudeberangkat = "",
    this.longitudeberangkat = "",
    this.nama = "",
    this.alamat = "",
    this.statussampai = 0,
    this.waktusampai = "",
    this.latitudesampai = "",
    this.longitudesampai = "",
    this.statusdatang = 0,
    this.waktudatang = "",
    this.latitudedatang = "",
    this.longitudedatang = "",
    this.total = 0,
    this.qty = 0,
    this.konversisatuan2 = 0,
    this.konversisatuan3 = 0,
  });

  factory TrackingOrderJualGetDataContent.fromJson(Map<String, dynamic> json) =>
      _$TrackingOrderJualGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingOrderJualGetDataContentToJson(this);

  final int nomor;
  @JsonKey(name: 'latitude_penerima')
  final String? latitudepenerima;
  @JsonKey(name: 'longitude_penerima')
  final String? longitudepenerima;
  @JsonKey(name: 'latitude_kirim')
  final String? latitudekirim;
  @JsonKey(name: 'longitude_kirim')
  final String? longitudekirim;
  @JsonKey(name: 'status_oj')
  final int? statusoj;
  @JsonKey(name: 'kode_oj')
  final String? kodeoj;
  @JsonKey(name: 'waktu_oj')
  final String? waktuoj;
  @JsonKey(name: 'status_do')
  final int? statusdo;
  @JsonKey(name: 'kode_do')
  final String? kodedo;
  @JsonKey(name: 'waktu_do')
  final String? waktudo;
  @JsonKey(name: 'status_sj')
  final int? statussj;
  @JsonKey(name: 'kode_sj')
  final String? kodesj;
  @JsonKey(name: 'waktu_sj')
  final String? waktusj;
  @JsonKey(name: 'status_berangkat')
  final int? statusberangkat;
  @JsonKey(name: 'waktu_berangkat')
  final String? waktuberangkat;
  @JsonKey(name: 'latitude_berangkat')
  final String? latitudeberangkat;
  @JsonKey(name: 'longitude_berangkat')
  final String? longitudeberangkat;
  final String? nama;
  final String? alamat;
  @JsonKey(name: 'status_sampai')
  final int? statussampai;
  @JsonKey(name: 'waktu_sampai')
  final String? waktusampai;
  @JsonKey(name: 'latitude_sampai')
  final String? latitudesampai;
  @JsonKey(name: 'longitude_sampai')
  final String? longitudesampai;
  @JsonKey(name: 'status_datang')
  final int? statusdatang;
  @JsonKey(name: 'waktu_datang')
  final String? waktudatang;
  @JsonKey(name: 'latitude_datang')
  final String? latitudedatang;
  @JsonKey(name: 'longitude_datang')
  final String? longitudedatang;
  final int? total;
  final int? qty;
  @JsonKey(name: 'konversi_satuan_2')
  final int? konversisatuan2;
  @JsonKey(name: 'konversi_satuan_3')
  final int? konversisatuan3;
}
