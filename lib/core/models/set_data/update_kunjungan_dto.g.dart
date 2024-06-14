// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_kunjungan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateKunjunganPayload _$UpdateKunjunganPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateKunjunganPayload(
      action: json['action'] as String,
      requestData: UpdateKunjunganRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateKunjunganPayloadToJson(
        UpdateKunjunganPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateKunjunganRequest _$UpdateKunjunganRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateKunjunganRequest(
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      mode: json['mode'] as String,
    );

Map<String, dynamic> _$UpdateKunjunganRequestToJson(
        UpdateKunjunganRequest instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'mode': instance.mode,
    };

UpdateKunjunganResponse _$UpdateKunjunganResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateKunjunganResponse(
      msg: json['msg'] as bool?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$UpdateKunjunganResponseToJson(
        UpdateKunjunganResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
    };
