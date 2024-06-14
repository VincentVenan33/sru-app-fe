import 'package:json_annotation/json_annotation.dart';

part 'delete_order_jual_dto.g.dart';

@JsonSerializable()
class DeleteOrderJualPayload {
  DeleteOrderJualPayload({
    required this.action,
    required this.dihapusoleh,
  });

  factory DeleteOrderJualPayload.fromJson(Map<String, dynamic> json) => _$DeleteOrderJualPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOrderJualPayloadToJson(this);

  final String action;
  @JsonKey(name: 'dihapus_oleh')
  final int dihapusoleh;
}

@JsonSerializable()
class DeleteOrderJualResponse {
  DeleteOrderJualResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory DeleteOrderJualResponse.fromJson(Map<String, dynamic> json) => _$DeleteOrderJualResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOrderJualResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int data;
}
