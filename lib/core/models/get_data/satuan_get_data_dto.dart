import 'package:json_annotation/json_annotation.dart';

part 'satuan_get_data_dto.g.dart';

@JsonSerializable()
class SatuanGetDataPayload {
  SatuanGetDataPayload({
    required this.action,
  });

  factory SatuanGetDataPayload.fromJson(Map<String, dynamic> json) => _$SatuanGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanGetDataPayloadToJson(this);

  final String action;
}

@JsonSerializable()
class SatuanGetDataResponse {
  SatuanGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory SatuanGetDataResponse.fromJson(Map<String, dynamic> json) => _$SatuanGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final SatuanGetDataResult data;
}

@JsonSerializable()
class SatuanGetDataResult {
  SatuanGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory SatuanGetDataResult.fromJson(Map<String, dynamic> json) => _$SatuanGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<SatuanGetDataContent> data;
}

@JsonSerializable()
class SatuanGetDataContent {
  SatuanGetDataContent({
    required this.nomor,
    this.nomormhusaha = 0,
    required this.kode,
    required this.nama,
    this.keterangan = "",
    this.total = 0,
    this.qty = 0,
  });

  factory SatuanGetDataContent.fromJson(Map<String, dynamic> json) => _$SatuanGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanGetDataContentToJson(this);

  final int nomor;
  final int? nomormhusaha;
  final String kode;
  final String nama;
  final String? keterangan;
  final int? total;
  final int? qty;
}
