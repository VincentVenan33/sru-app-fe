import 'package:json_annotation/json_annotation.dart';

part 'update_kunjungan_dto.g.dart';

@JsonSerializable()
class UpdateKunjunganPayload {
  UpdateKunjunganPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateKunjunganPayload.fromJson(Map<String, dynamic> json) => _$UpdateKunjunganPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateKunjunganPayloadToJson(this);

  final String action;
  final UpdateKunjunganRequest requestData;
}

@JsonSerializable()
class UpdateKunjunganRequest {
  UpdateKunjunganRequest({
    required this.longitude,
    required this.latitude,
    required this.mode,
  });

  factory UpdateKunjunganRequest.fromJson(Map<String, dynamic> json) => _$UpdateKunjunganRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateKunjunganRequestToJson(this);

  final double? latitude;
  final double? longitude;
  final String mode;
}

@JsonSerializable()
class UpdateKunjunganResponse {
  UpdateKunjunganResponse({
    required this.msg,
    required this.code,
  });

  factory UpdateKunjunganResponse.fromJson(Map<String, dynamic> json) => _$UpdateKunjunganResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateKunjunganResponseToJson(this);

  final bool? msg;
  final int? code;
}