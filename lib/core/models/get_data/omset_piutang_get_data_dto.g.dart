// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omset_piutang_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmsetPiutangGetDataPayload _$OmsetPiutangGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    OmsetPiutangGetDataPayload(
      action: json['action'] as String,
    );

Map<String, dynamic> _$OmsetPiutangGetDataPayloadToJson(
        OmsetPiutangGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
    };

OmsetPiutangGetDataResponse _$OmsetPiutangGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    OmsetPiutangGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: OmsetPiutangGetDataResult.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OmsetPiutangGetDataResponseToJson(
        OmsetPiutangGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

OmsetPiutangGetDataResult _$OmsetPiutangGetDataResultFromJson(
        Map<String, dynamic> json) =>
    OmsetPiutangGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              OmsetPiutangGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OmsetPiutangGetDataResultToJson(
        OmsetPiutangGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

OmsetPiutangGetDataContent _$OmsetPiutangGetDataContentFromJson(
        Map<String, dynamic> json) =>
    OmsetPiutangGetDataContent(
      nomor: json['nomor'] as int,
      kode: json['kode'] as String? ?? "",
      transaksikode: json['transaksi_kode'] as String? ?? "",
      tanggal: json['tanggal'] as String? ?? "",
      transaksitanggal: json['transaksi_tanggal'] as String? ?? "",
      total: (json['total'] as num?)?.toDouble() ?? 0,
      qty: (json['qty'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$OmsetPiutangGetDataContentToJson(
        OmsetPiutangGetDataContent instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'kode': instance.kode,
      'transaksi_kode': instance.transaksikode,
      'tanggal': instance.tanggal,
      'transaksi_tanggal': instance.transaksitanggal,
      'total': instance.total,
      'qty': instance.qty,
    };
