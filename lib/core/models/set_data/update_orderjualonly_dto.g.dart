// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_orderjualonly_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderJualOnlyPayload _$UpdateOrderJualOnlyPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualOnlyPayload(
      action: json['action'] as String,
      requestData: UpdateOrderJualOnlyRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateOrderJualOnlyPayloadToJson(
        UpdateOrderJualOnlyPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateOrderJualOnlyRequest _$UpdateOrderJualOnlyRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualOnlyRequest(
      nomormhrelasicust: json['nomormhrelasi_cust'] as String,
      ppnprosentase: json['ppn_prosentase'] as String,
      statusppn: json['status_ppn'] as int,
      ppnnominal: json['ppn_nominal'] as int,
      diskonprosentase: json['diskon_prosentase'] as int,
      diskonnominal: json['diskon_nominal'] as int,
      dpp: json['dpp'] as int,
      totalbiaya: json['total_biaya'] as int,
      total: json['total'] as int,
      subtotal2: json['subtotal2'] as int,
      tanggal: json['tanggal'] as String,
      kode: json['kode'] as String,
      diubaholeh: json['diubah_oleh'] as int?,
    );

Map<String, dynamic> _$UpdateOrderJualOnlyRequestToJson(
        UpdateOrderJualOnlyRequest instance) =>
    <String, dynamic>{
      'nomormhrelasi_cust': instance.nomormhrelasicust,
      'ppn_prosentase': instance.ppnprosentase,
      'status_ppn': instance.statusppn,
      'ppn_nominal': instance.ppnnominal,
      'diskon_prosentase': instance.diskonprosentase,
      'diskon_nominal': instance.diskonnominal,
      'dpp': instance.dpp,
      'total_biaya': instance.totalbiaya,
      'total': instance.total,
      'subtotal2': instance.subtotal2,
      'tanggal': instance.tanggal,
      'kode': instance.kode,
      'diubah_oleh': instance.diubaholeh,
    };

UpdateOrderJualOnlyResponse _$UpdateOrderJualOnlyResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualOnlyResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int?,
    );

Map<String, dynamic> _$UpdateOrderJualOnlyResponseToJson(
        UpdateOrderJualOnlyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };
