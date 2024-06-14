// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_kunjungan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateKunjunganPayload _$CreateKunjunganPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateKunjunganPayload(
      action: json['action'] as String,
      requestData: CreateKunjunganRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateKunjunganPayloadToJson(
        CreateKunjunganPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

CreateKunjunganRequest _$CreateKunjunganRequestFromJson(
        Map<String, dynamic> json) =>
    CreateKunjunganRequest(
      formatcode: json['format_code'] as String,
      kode: json['kode'] as String,
      nomormhcustomer: json['nomormhcustomer'] as int,
      nomormhsales: json['nomormhsales'] as int,
      tanggal: json['tanggal'] as String,
      waktuin: json['waktu_in'] as String,
      waktuout: json['waktu_out'] as String,
      judul: json['judul'] as String,
      rencana: json['rencana'] as String,
      gambar: json['gambar'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CreateKunjunganRequestToJson(
        CreateKunjunganRequest instance) =>
    <String, dynamic>{
      'format_code': instance.formatcode,
      'kode': instance.kode,
      'nomormhcustomer': instance.nomormhcustomer,
      'nomormhsales': instance.nomormhsales,
      'tanggal': instance.tanggal,
      'waktu_in': instance.waktuin,
      'waktu_out': instance.waktuout,
      'judul': instance.judul,
      'rencana': instance.rencana,
      'gambar': instance.gambar,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

CreateKunjunganResponse _$CreateKunjunganResponseFromJson(
        Map<String, dynamic> json) =>
    CreateKunjunganResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: SetKunjunganDataContent.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateKunjunganResponseToJson(
        CreateKunjunganResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

SetKunjunganDataContent _$SetKunjunganDataContentFromJson(
        Map<String, dynamic> json) =>
    SetKunjunganDataContent(
      kode: json['kode'] as String,
      nomormhcustomer: json['nomormhcustomer'] as String,
      nomormhsales: json['nomormhsales'] as String,
      tanggal: json['tanggal'] as String,
      waktuin: json['waktu_in'] as String,
      waktuout: json['waktu_out'] as String,
      judul: json['judul'] as String,
      rencana: json['rencana'] as String,
      gambar: json['gambar'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SetKunjunganDataContentToJson(
        SetKunjunganDataContent instance) =>
    <String, dynamic>{
      'kode': instance.kode,
      'nomormhcustomer': instance.nomormhcustomer,
      'nomormhsales': instance.nomormhsales,
      'tanggal': instance.tanggal,
      'waktu_in': instance.waktuin,
      'waktu_out': instance.waktuout,
      'judul': instance.judul,
      'rencana': instance.rencana,
      'gambar': instance.gambar,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'id': instance.id,
    };
