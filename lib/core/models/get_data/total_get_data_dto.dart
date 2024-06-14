import 'package:json_annotation/json_annotation.dart';

part 'total_get_data_dto.g.dart';

@JsonSerializable()
class TotalGetDataPayload {
  TotalGetDataPayload({
    required this.action,
  });

  factory TotalGetDataPayload.fromJson(Map<String, dynamic> json) => _$TotalGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$TotalGetDataPayloadToJson(this);

  final String action;
}

@JsonSerializable()
class TotalGetDataResponse {
  TotalGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory TotalGetDataResponse.fromJson(Map<String, dynamic> json) => _$TotalGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TotalGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final List<TotalGetDataContent> data;
}

@JsonSerializable()
class TotalGetDataContent {
  TotalGetDataContent({
    required this.tipe,
    required this.total1,
    required this.total2,
    required this.total3,
  });

  factory TotalGetDataContent.fromJson(Map<String, dynamic> json) => _$TotalGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$TotalGetDataContentToJson(this);

  final String tipe;
  final int total1;
  final int total2;
  final int total3;
}
