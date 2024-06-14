// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_orderjual_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderJualDetailPayload _$UpdateOrderJualDetailPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailPayload(
      action: json['action'] as String,
      requestData: UpdateOrderJualDetailRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateOrderJualDetailPayloadToJson(
        UpdateOrderJualDetailPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateOrderJualDetailRequest _$UpdateOrderJualDetailRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailRequest(
      nomor: json['nomor'] as int?,
      nomorthorderjual: json['nomorthorderjual'] as int?,
      nomormhbarang: json['nomormhbarang'] as int?,
      nomormhsatuan: json['nomormhsatuan'] as int?,
      qty: json['qty'] as int?,
      netto: json['netto'] as int?,
      disctotal: json['disc_total'] as int?,
      discdirect: json['disc_direct'] as int?,
      disc3: json['disc_3'] as int?,
      disc2: json['disc_2'] as int?,
      disc1: json['disc_1'] as int?,
      satuanqty: json['satuan_qty'] as String,
      isi: json['isi'] as int?,
      satuanisi: json['satuan_isi'] as String,
      harga: json['harga'] as int?,
      subtotal: json['subtotal'] as int,
      konversisatuan: json['konversi_satuan'] as int,
      diubaholeh: json['diubah_oleh'] as int,
    );

Map<String, dynamic> _$UpdateOrderJualDetailRequestToJson(
        UpdateOrderJualDetailRequest instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nomorthorderjual': instance.nomorthorderjual,
      'nomormhbarang': instance.nomormhbarang,
      'nomormhsatuan': instance.nomormhsatuan,
      'qty': instance.qty,
      'netto': instance.netto,
      'disc_total': instance.disctotal,
      'disc_direct': instance.discdirect,
      'disc_3': instance.disc3,
      'disc_2': instance.disc2,
      'disc_1': instance.disc1,
      'satuan_qty': instance.satuanqty,
      'isi': instance.isi,
      'satuan_isi': instance.satuanisi,
      'harga': instance.harga,
      'subtotal': instance.subtotal,
      'konversi_satuan': instance.konversisatuan,
      'diubah_oleh': instance.diubaholeh,
    };

UpdateOrderJualDetailResponse _$UpdateOrderJualDetailResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int?,
    );

Map<String, dynamic> _$UpdateOrderJualDetailResponseToJson(
        UpdateOrderJualDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };
