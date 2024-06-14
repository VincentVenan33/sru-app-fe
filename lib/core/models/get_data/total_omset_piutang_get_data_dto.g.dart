// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_omset_piutang_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalOmsetPiutangGetDataPayload _$TotalOmsetPiutangGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    TotalOmsetPiutangGetDataPayload(
      action: json['action'] as String,
    );

Map<String, dynamic> _$TotalOmsetPiutangGetDataPayloadToJson(
        TotalOmsetPiutangGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
    };

TotalOmsetPiutangGetDataResponse _$TotalOmsetPiutangGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    TotalOmsetPiutangGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: TotalOmsetPiutangGetDataResult.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TotalOmsetPiutangGetDataResponseToJson(
        TotalOmsetPiutangGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

TotalOmsetPiutangGetDataResult _$TotalOmsetPiutangGetDataResultFromJson(
        Map<String, dynamic> json) =>
    TotalOmsetPiutangGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => TotalOmsetPiutangGetDataContent.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TotalOmsetPiutangGetDataResultToJson(
        TotalOmsetPiutangGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

TotalOmsetPiutangGetDataContent _$TotalOmsetPiutangGetDataContentFromJson(
        Map<String, dynamic> json) =>
    TotalOmsetPiutangGetDataContent(
      total: (json['total'] as num?)?.toDouble() ?? 0,
      qty: (json['qty'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$TotalOmsetPiutangGetDataContentToJson(
        TotalOmsetPiutangGetDataContent instance) =>
    <String, dynamic>{
      'total': instance.total,
      'qty': instance.qty,
    };
