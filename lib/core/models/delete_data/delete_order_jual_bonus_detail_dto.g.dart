// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_order_jual_bonus_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteOrderJualBonusDetailPayload _$DeleteOrderJualBonusDetailPayloadFromJson(
        Map<String, dynamic> json) =>
    DeleteOrderJualBonusDetailPayload(
      action: json['action'] as String,
      dihapusoleh: json['dihapus_oleh'] as int,
    );

Map<String, dynamic> _$DeleteOrderJualBonusDetailPayloadToJson(
        DeleteOrderJualBonusDetailPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'dihapus_oleh': instance.dihapusoleh,
    };

DeleteOrderJualBonusDetailResponse _$DeleteOrderJualBonusDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteOrderJualBonusDetailResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int,
    );

Map<String, dynamic> _$DeleteOrderJualBonusDetailResponseToJson(
        DeleteOrderJualBonusDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };
