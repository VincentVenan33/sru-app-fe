// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_order_jual_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteOrderJualPayload _$DeleteOrderJualPayloadFromJson(
        Map<String, dynamic> json) =>
    DeleteOrderJualPayload(
      action: json['action'] as String,
      dihapusoleh: json['dihapus_oleh'] as int,
    );

Map<String, dynamic> _$DeleteOrderJualPayloadToJson(
        DeleteOrderJualPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'dihapus_oleh': instance.dihapusoleh,
    };

DeleteOrderJualResponse _$DeleteOrderJualResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteOrderJualResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int,
    );

Map<String, dynamic> _$DeleteOrderJualResponseToJson(
        DeleteOrderJualResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };
