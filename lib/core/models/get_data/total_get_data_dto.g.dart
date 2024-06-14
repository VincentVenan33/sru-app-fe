// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalGetDataPayload _$TotalGetDataPayloadFromJson(Map<String, dynamic> json) =>
    TotalGetDataPayload(
      action: json['action'] as String,
    );

Map<String, dynamic> _$TotalGetDataPayloadToJson(
        TotalGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
    };

TotalGetDataResponse _$TotalGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    TotalGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => TotalGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TotalGetDataResponseToJson(
        TotalGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

TotalGetDataContent _$TotalGetDataContentFromJson(Map<String, dynamic> json) =>
    TotalGetDataContent(
      tipe: json['tipe'] as String,
      total1: json['total1'] as int,
      total2: json['total2'] as int,
      total3: json['total3'] as int,
    );

Map<String, dynamic> _$TotalGetDataContentToJson(
        TotalGetDataContent instance) =>
    <String, dynamic>{
      'tipe': instance.tipe,
      'total1': instance.total1,
      'total2': instance.total2,
      'total3': instance.total3,
    };
