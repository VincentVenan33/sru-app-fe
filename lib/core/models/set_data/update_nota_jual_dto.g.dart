// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_nota_jual_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNotaJualPayload _$UpdateNotaJualPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateNotaJualPayload(
      action: json['action'] as String,
      requestData: UpdateNotaJualRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateNotaJualPayloadToJson(
        UpdateNotaJualPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateNotaJualRequest _$UpdateNotaJualRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateNotaJualRequest(
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      mode: json['mode'] as String,
      nomormhadmin: json['nomormhadmin'] as int?,
    );

Map<String, dynamic> _$UpdateNotaJualRequestToJson(
        UpdateNotaJualRequest instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'mode': instance.mode,
      'nomormhadmin': instance.nomormhadmin,
    };

UpdateNotaJualResponse _$UpdateNotaJualResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateNotaJualResponse(
      msg: json['msg'] as bool?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$UpdateNotaJualResponseToJson(
        UpdateNotaJualResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
    };
