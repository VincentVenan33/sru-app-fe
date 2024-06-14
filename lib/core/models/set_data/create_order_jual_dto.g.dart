// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_jual_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderJualPayload _$CreateOrderJualPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualPayload(
      action: json['action'] as String,
      requestData: CreateOrderJualRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderJualPayloadToJson(
        CreateOrderJualPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

CreateOrderJualRequest _$CreateOrderJualRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualRequest(
      formatcode: json['formatcode'] as String,
      nomormhcustomer: json['nomormhcustomer'] as int,
      ppnprosentase: json['ppn_prosentase'] as String,
      statusppn: json['status_ppn'] as int?,
      tanggal: json['tanggal'] as String,
      kode: json['kode'] as String,
      dibuatoleh: json['dibuat_oleh'] as int?,
    );

Map<String, dynamic> _$CreateOrderJualRequestToJson(
        CreateOrderJualRequest instance) =>
    <String, dynamic>{
      'formatcode': instance.formatcode,
      'nomormhcustomer': instance.nomormhcustomer,
      'ppn_prosentase': instance.ppnprosentase,
      'status_ppn': instance.statusppn,
      'tanggal': instance.tanggal,
      'kode': instance.kode,
      'dibuat_oleh': instance.dibuatoleh,
    };

CreateOrderJualResponse _$CreateOrderJualResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: SetOrderJualDataContent.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderJualResponseToJson(
        CreateOrderJualResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

SetOrderJualDataContent _$SetOrderJualDataContentFromJson(
        Map<String, dynamic> json) =>
    SetOrderJualDataContent(
      kode: json['kode'] as String,
      nomormhcustomer: json['nomormhcustomer'] as int,
      ppnprosentase: json['ppn_prosentase'] as String,
      statusppn: json['status_ppn'] as int?,
      tanggal: json['tanggal'] as String,
      dibuatoleh: json['dibuat_oleh'] as int?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SetOrderJualDataContentToJson(
        SetOrderJualDataContent instance) =>
    <String, dynamic>{
      'kode': instance.kode,
      'nomormhcustomer': instance.nomormhcustomer,
      'ppn_prosentase': instance.ppnprosentase,
      'status_ppn': instance.statusppn,
      'tanggal': instance.tanggal,
      'dibuat_oleh': instance.dibuatoleh,
      'id': instance.id,
    };

ListDetailItem _$ListDetailItemFromJson(Map<String, dynamic> json) =>
    ListDetailItem(
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              CreateOrderJualDetailRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDetailItemToJson(ListDetailItem instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

DetailItem _$DetailItemFromJson(Map<String, dynamic> json) => DetailItem(
      nomor: json['nomor'] as int,
      nama: json['nama'] as String?,
      qty: json['qty'] as int,
      netto: json['netto'] as int,
      disctotal: json['disctotal'] as int,
      discdirect: json['discdirect'] as int,
      disc3: json['disc3'] as int,
      disc2: json['disc2'] as int,
      disc1: json['disc1'] as int,
      satuanqty: json['satuanqty'] as int,
      satuanqtynama: json['satuanqtynama'] as String?,
      isi: json['isi'] as int,
      satuanisi: json['satuanisi'] as int,
      satuanisinama: json['satuanisinama'] as String?,
      harga: json['harga'] as int,
      subtotal: json['subtotal'] as int,
      konversisatuan: json['konversisatuan'] as int,
    );

Map<String, dynamic> _$DetailItemToJson(DetailItem instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nama': instance.nama,
      'qty': instance.qty,
      'netto': instance.netto,
      'disctotal': instance.disctotal,
      'discdirect': instance.discdirect,
      'disc3': instance.disc3,
      'disc2': instance.disc2,
      'disc1': instance.disc1,
      'satuanqty': instance.satuanqty,
      'satuanqtynama': instance.satuanqtynama,
      'isi': instance.isi,
      'satuanisi': instance.satuanisi,
      'satuanisinama': instance.satuanisinama,
      'harga': instance.harga,
      'subtotal': instance.subtotal,
      'konversisatuan': instance.konversisatuan,
    };
