import 'package:json_annotation/json_annotation.dart';

part 'omset_piutang_get_data_dto.g.dart';

@JsonSerializable()
class OmsetPiutangGetDataPayload {
  OmsetPiutangGetDataPayload({
    required this.action,
  });

  factory OmsetPiutangGetDataPayload.fromJson(Map<String, dynamic> json) => _$OmsetPiutangGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OmsetPiutangGetDataPayloadToJson(this);

  final String action;
}

@JsonSerializable()
class OmsetPiutangGetDataResponse {
  OmsetPiutangGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory OmsetPiutangGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$OmsetPiutangGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OmsetPiutangGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final OmsetPiutangGetDataResult data;
}

@JsonSerializable()
class OmsetPiutangGetDataResult {
  OmsetPiutangGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory OmsetPiutangGetDataResult.fromJson(Map<String, dynamic> json) => _$OmsetPiutangGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$OmsetPiutangGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<OmsetPiutangGetDataContent> data;
}

@JsonSerializable()
class OmsetPiutangGetDataContent {
  OmsetPiutangGetDataContent({
    required this.nomor,
    this.kode = "",
    this.transaksikode = "",
    this.tanggal = "",
    this.transaksitanggal = "",
    this.total = 0,
    this.qty = 0,
  });

  factory OmsetPiutangGetDataContent.fromJson(Map<String, dynamic> json) => _$OmsetPiutangGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$OmsetPiutangGetDataContentToJson(this);

  final int nomor;

  final String kode;
  @JsonKey(name: 'transaksi_kode')
  final String? transaksikode;
  final String? tanggal;
  @JsonKey(name: 'transaksi_tanggal')
  final String? transaksitanggal;
  final double? total;
  final double? qty;
}
