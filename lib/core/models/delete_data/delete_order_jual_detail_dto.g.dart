// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_order_jual_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteOrderJualDetailPayload _$DeleteOrderJualDetailPayloadFromJson(
        Map<String, dynamic> json) =>
    DeleteOrderJualDetailPayload(
      action: json['action'] as String,
      dihapusoleh: json['dihapus_oleh'] as int,
    );

Map<String, dynamic> _$DeleteOrderJualDetailPayloadToJson(
        DeleteOrderJualDetailPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'dihapus_oleh': instance.dihapusoleh,
    };

DeleteOrderJualDetailResponse _$DeleteOrderJualDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteOrderJualDetailResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int,
    );

Map<String, dynamic> _$DeleteOrderJualDetailResponseToJson(
        DeleteOrderJualDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };
