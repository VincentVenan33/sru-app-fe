// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_order_jual_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackingOrderJualGetDataPayload _$TrackingOrderJualGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    TrackingOrderJualGetDataPayload(
      action: json['action'] as String,
      filters: TrackingOrderJualGetFilter.fromJson(
          json['filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackingOrderJualGetDataPayloadToJson(
        TrackingOrderJualGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
    };

TrackingOrderJualGetFilter _$TrackingOrderJualGetFilterFromJson(
        Map<String, dynamic> json) =>
    TrackingOrderJualGetFilter(
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$TrackingOrderJualGetFilterToJson(
        TrackingOrderJualGetFilter instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
    };

TrackingOrderJualGetDataResponse _$TrackingOrderJualGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    TrackingOrderJualGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: TrackingOrderJualGetDataResult.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackingOrderJualGetDataResponseToJson(
        TrackingOrderJualGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

TrackingOrderJualGetDataResult _$TrackingOrderJualGetDataResultFromJson(
        Map<String, dynamic> json) =>
    TrackingOrderJualGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => TrackingOrderJualGetDataContent.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackingOrderJualGetDataResultToJson(
        TrackingOrderJualGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

TrackingOrderJualGetDataContent _$TrackingOrderJualGetDataContentFromJson(
        Map<String, dynamic> json) =>
    TrackingOrderJualGetDataContent(
      nomor: json['nomor'] as int,
      latitudepenerima: json['latitude_penerima'] as String? ?? "",
      longitudepenerima: json['longitude_penerima'] as String? ?? "",
      latitudekirim: json['latitude_kirim'] as String? ?? "",
      longitudekirim: json['longitude_kirim'] as String? ?? "",
      statusoj: json['status_oj'] as int? ?? 0,
      kodeoj: json['kode_oj'] as String? ?? "",
      waktuoj: json['waktu_oj'] as String? ?? "",
      statusdo: json['status_do'] as int? ?? 0,
      kodedo: json['kode_do'] as String? ?? "",
      waktudo: json['waktu_do'] as String? ?? "",
      statussj: json['status_sj'] as int? ?? 0,
      kodesj: json['kode_sj'] as String? ?? "",
      waktusj: json['waktu_sj'] as String? ?? "",
      statusberangkat: json['status_berangkat'] as int? ?? 0,
      waktuberangkat: json['waktu_berangkat'] as String? ?? "",
      latitudeberangkat: json['latitude_berangkat'] as String? ?? "",
      longitudeberangkat: json['longitude_berangkat'] as String? ?? "",
      nama: json['nama'] as String? ?? "",
      alamat: json['alamat'] as String? ?? "",
      statussampai: json['status_sampai'] as int? ?? 0,
      waktusampai: json['waktu_sampai'] as String? ?? "",
      latitudesampai: json['latitude_sampai'] as String? ?? "",
      longitudesampai: json['longitude_sampai'] as String? ?? "",
      statusdatang: json['status_datang'] as int? ?? 0,
      waktudatang: json['waktu_datang'] as String? ?? "",
      latitudedatang: json['latitude_datang'] as String? ?? "",
      longitudedatang: json['longitude_datang'] as String? ?? "",
      total: json['total'] as int? ?? 0,
      qty: json['qty'] as int? ?? 0,
      konversisatuan2: json['konversi_satuan_2'] as int? ?? 0,
      konversisatuan3: json['konversi_satuan_3'] as int? ?? 0,
    );

Map<String, dynamic> _$TrackingOrderJualGetDataContentToJson(
        TrackingOrderJualGetDataContent instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'latitude_penerima': instance.latitudepenerima,
      'longitude_penerima': instance.longitudepenerima,
      'latitude_kirim': instance.latitudekirim,
      'longitude_kirim': instance.longitudekirim,
      'status_oj': instance.statusoj,
      'kode_oj': instance.kodeoj,
      'waktu_oj': instance.waktuoj,
      'status_do': instance.statusdo,
      'kode_do': instance.kodedo,
      'waktu_do': instance.waktudo,
      'status_sj': instance.statussj,
      'kode_sj': instance.kodesj,
      'waktu_sj': instance.waktusj,
      'status_berangkat': instance.statusberangkat,
      'waktu_berangkat': instance.waktuberangkat,
      'latitude_berangkat': instance.latitudeberangkat,
      'longitude_berangkat': instance.longitudeberangkat,
      'nama': instance.nama,
      'alamat': instance.alamat,
      'status_sampai': instance.statussampai,
      'waktu_sampai': instance.waktusampai,
      'latitude_sampai': instance.latitudesampai,
      'longitude_sampai': instance.longitudesampai,
      'status_datang': instance.statusdatang,
      'waktu_datang': instance.waktudatang,
      'latitude_datang': instance.latitudedatang,
      'longitude_datang': instance.longitudedatang,
      'total': instance.total,
      'qty': instance.qty,
      'konversi_satuan_2': instance.konversisatuan2,
      'konversi_satuan_3': instance.konversisatuan3,
    };
