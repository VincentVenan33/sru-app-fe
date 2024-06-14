import 'package:json_annotation/json_annotation.dart';

part 'total_omset_piutang_get_data_dto.g.dart';

@JsonSerializable()
class TotalOmsetPiutangGetDataPayload {
  TotalOmsetPiutangGetDataPayload({
    required this.action,
  });

  factory TotalOmsetPiutangGetDataPayload.fromJson(Map<String, dynamic> json) => _$TotalOmsetPiutangGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$TotalOmsetPiutangGetDataPayloadToJson(this);

  final String action;
}

@JsonSerializable()
class TotalOmsetPiutangGetDataResponse {
  TotalOmsetPiutangGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory TotalOmsetPiutangGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TotalOmsetPiutangGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TotalOmsetPiutangGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final TotalOmsetPiutangGetDataResult data;
}

@JsonSerializable()
class TotalOmsetPiutangGetDataResult {
  TotalOmsetPiutangGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory TotalOmsetPiutangGetDataResult.fromJson(Map<String, dynamic> json) => _$TotalOmsetPiutangGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$TotalOmsetPiutangGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<TotalOmsetPiutangGetDataContent> data;
}

@JsonSerializable()
class TotalOmsetPiutangGetDataContent {
  TotalOmsetPiutangGetDataContent({
    this.total = 0,
    this.qty = 0,
  });

  factory TotalOmsetPiutangGetDataContent.fromJson(Map<String, dynamic> json) => _$TotalOmsetPiutangGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$TotalOmsetPiutangGetDataContentToJson(this);

  final double? total;
  final double? qty;
}
