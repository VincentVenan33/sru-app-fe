import 'package:json_annotation/json_annotation.dart';

part 'delete_order_jual_bonus_detail_dto.g.dart';

@JsonSerializable()
class DeleteOrderJualBonusDetailPayload {
  DeleteOrderJualBonusDetailPayload({
    required this.action,
    required this.dihapusoleh,
  });

  factory DeleteOrderJualBonusDetailPayload.fromJson(Map<String, dynamic> json) => _$DeleteOrderJualBonusDetailPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOrderJualBonusDetailPayloadToJson(this);

  final String action;
  @JsonKey(name: 'dihapus_oleh')
  final int dihapusoleh;
}

@JsonSerializable()
class DeleteOrderJualBonusDetailResponse {
  DeleteOrderJualBonusDetailResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory DeleteOrderJualBonusDetailResponse.fromJson(Map<String, dynamic> json) => _$DeleteOrderJualBonusDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOrderJualBonusDetailResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int data;
}
