// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'satuan_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SatuanGetDataPayload _$SatuanGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    SatuanGetDataPayload(
      action: json['action'] as String,
    );

Map<String, dynamic> _$SatuanGetDataPayloadToJson(
        SatuanGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
    };

SatuanGetDataResponse _$SatuanGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    SatuanGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: SatuanGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SatuanGetDataResponseToJson(
        SatuanGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

SatuanGetDataResult _$SatuanGetDataResultFromJson(Map<String, dynamic> json) =>
    SatuanGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => SatuanGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SatuanGetDataResultToJson(
        SatuanGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

SatuanGetDataContent _$SatuanGetDataContentFromJson(
        Map<String, dynamic> json) =>
    SatuanGetDataContent(
      nomor: json['nomor'] as int,
      nomormhusaha: json['nomormhusaha'] as int? ?? 0,
      kode: json['kode'] as String,
      nama: json['nama'] as String,
      keterangan: json['keterangan'] as String? ?? "",
      total: json['total'] as int? ?? 0,
      qty: json['qty'] as int? ?? 0,
    );

Map<String, dynamic> _$SatuanGetDataContentToJson(
        SatuanGetDataContent instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nomormhusaha': instance.nomormhusaha,
      'kode': instance.kode,
      'nama': instance.nama,
      'keterangan': instance.keterangan,
      'total': instance.total,
      'qty': instance.qty,
    };
