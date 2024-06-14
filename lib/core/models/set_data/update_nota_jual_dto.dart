import 'package:json_annotation/json_annotation.dart';

part 'update_nota_jual_dto.g.dart';

@JsonSerializable()
class UpdateNotaJualPayload {
  UpdateNotaJualPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateNotaJualPayload.fromJson(Map<String, dynamic> json) => _$UpdateNotaJualPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNotaJualPayloadToJson(this);

  final String action;
  final UpdateNotaJualRequest requestData;
}

@JsonSerializable()
class UpdateNotaJualRequest {
  UpdateNotaJualRequest({
    required this.longitude,
    required this.latitude,
    required this.mode,
    required this.nomormhadmin,
  });

  factory UpdateNotaJualRequest.fromJson(Map<String, dynamic> json) => _$UpdateNotaJualRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNotaJualRequestToJson(this);

  final double? latitude;
  final double? longitude;
  final String mode;
  final int? nomormhadmin;
}

@JsonSerializable()
class UpdateNotaJualResponse {
  UpdateNotaJualResponse({
    required this.msg,
    required this.code,
  });

  factory UpdateNotaJualResponse.fromJson(Map<String, dynamic> json) => _$UpdateNotaJualResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNotaJualResponseToJson(this);

  final bool? msg;
  final int? code;
}