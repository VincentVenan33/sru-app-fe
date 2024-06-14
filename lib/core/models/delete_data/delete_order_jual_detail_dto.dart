import 'package:json_annotation/json_annotation.dart';

part 'delete_order_jual_detail_dto.g.dart';

@JsonSerializable()
class DeleteOrderJualDetailPayload {
  DeleteOrderJualDetailPayload({
    required this.action,
    required this.dihapusoleh,
  });

  factory DeleteOrderJualDetailPayload.fromJson(Map<String, dynamic> json) => _$DeleteOrderJualDetailPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOrderJualDetailPayloadToJson(this);

  final String action;
  @JsonKey(name: 'dihapus_oleh')
  final int dihapusoleh;
}

@JsonSerializable()
class DeleteOrderJualDetailResponse {
  DeleteOrderJualDetailResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory DeleteOrderJualDetailResponse.fromJson(Map<String, dynamic> json) => _$DeleteOrderJualDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOrderJualDetailResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int data;
}
