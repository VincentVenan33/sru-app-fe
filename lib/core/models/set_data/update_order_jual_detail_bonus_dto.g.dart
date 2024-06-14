// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_jual_detail_bonus_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderJualDetailBonusPayload _$UpdateOrderJualDetailBonusPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailBonusPayload(
      action: json['action'] as String,
      requestData: UpdateOrderJualDetailBonusRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateOrderJualDetailBonusPayloadToJson(
        UpdateOrderJualDetailBonusPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateOrderJualDetailBonusRequest _$UpdateOrderJualDetailBonusRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailBonusRequest(
      nomormhcustomer: json['nomormhcustomer'] as String,
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
      detail: (json['detail'] as List<dynamic>)
          .map((e) => CreateDetailRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateOrderJualDetailBonusRequestToJson(
        UpdateOrderJualDetailBonusRequest instance) =>
    <String, dynamic>{
      'nomormhcustomer': instance.nomormhcustomer,
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
      'detail': instance.detail,
    };

UpdateDetailRequest _$UpdateDetailRequestFromJson(Map<String, dynamic> json) =>
    UpdateDetailRequest(
      orderjualdetail: (json['order_jual_detail'] as List<dynamic>)
          .map((e) =>
              UpdateOrderJualDetailRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateDetailRequestToJson(
        UpdateDetailRequest instance) =>
    <String, dynamic>{
      'order_jual_detail': instance.orderjualdetail,
    };

UpdateOrderJualDetailRequest _$UpdateOrderJualDetailRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailRequest(
      nomor: json['nomor'] as int?,
      nomormhbarang: json['nomormhbarang'] as int,
      kode: json['kode'] as String?,
      nama: json['nama'] as String?,
      nomormhsatuan: json['nomormhsatuan'] as int,
      qty: json['qty'] as int,
      netto: json['netto'] as int,
      disctotal: json['disc_total'] as int,
      discdirect: json['disc_direct'] as int,
      disc3: json['disc_3'] as int,
      disc2: json['disc_2'] as int,
      disc1: json['disc_1'] as int,
      satuanqty: json['satuan_qty'] as String?,
      isi: json['isi'] as int,
      satuanisi: json['satuan_isi'] as String?,
      harga: json['harga'] as int,
      subtotal: json['subtotal'] as int,
      konversisatuan: json['konversi_satuan'] as int?,
    );

Map<String, dynamic> _$UpdateOrderJualDetailRequestToJson(
        UpdateOrderJualDetailRequest instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nomormhbarang': instance.nomormhbarang,
      'kode': instance.kode,
      'nama': instance.nama,
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
    };

UpdateOrderJualBonusDetailRequest _$UpdateOrderJualBonusDetailRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualBonusDetailRequest(
      nomor: json['nomor'] as int?,
      nomormhbarang: json['nomormhbarang'] as int,
      nomormhsatuan: json['nomormhsatuan'] as int,
      qtyunit: json['qty_unit'] as int,
      satuanunit: json['satuan_unit'] as String,
      qtyisi: json['qty_isi'] as int,
      satuanisi: json['satuan_isi'] as String,
      konversisatuan: json['konversi_satuan'] as int,
      selectedsatuan: json['selected_satuan'] as int,
    );

Map<String, dynamic> _$UpdateOrderJualBonusDetailRequestToJson(
        UpdateOrderJualBonusDetailRequest instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nomormhbarang': instance.nomormhbarang,
      'nomormhsatuan': instance.nomormhsatuan,
      'qty_unit': instance.qtyunit,
      'satuan_unit': instance.satuanunit,
      'qty_isi': instance.qtyisi,
      'satuan_isi': instance.satuanisi,
      'konversi_satuan': instance.konversisatuan,
      'selected_satuan': instance.selectedsatuan,
    };

UpdateOrderJualDetailResponse _$UpdateOrderJualDetailResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: SetUpdateOrderJualDetailDataContent.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateOrderJualDetailResponseToJson(
        UpdateOrderJualDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

SetUpdateOrderJualDetailDataContent
    _$SetUpdateOrderJualDetailDataContentFromJson(Map<String, dynamic> json) =>
        SetUpdateOrderJualDetailDataContent(
          kode: json['kode'] as String,
          nomormhrelasicust: json['nomormhrelasi_cust'] as String,
          nomormhrelasisales: json['nomormhrelasi_sales'] as String,
          nomormhcustomer: json['nomormhcustomer'] as String,
          ppnprosentase: json['ppn_prosentase'] as String,
          statusppn: json['status_ppn'] as int,
          tanggal: json['tanggal'] as String,
          dibuatoleh: json['dibuat_oleh'] as int,
          diubahpada: json['diubah_pada'] as String,
          dibuatpada: json['dibuat_pada'] as String,
          nomor: json['nomor'] as int,
        );

Map<String, dynamic> _$SetUpdateOrderJualDetailDataContentToJson(
        SetUpdateOrderJualDetailDataContent instance) =>
    <String, dynamic>{
      'kode': instance.kode,
      'nomormhrelasi_cust': instance.nomormhrelasicust,
      'nomormhrelasi_sales': instance.nomormhrelasisales,
      'nomormhcustomer': instance.nomormhcustomer,
      'ppn_prosentase': instance.ppnprosentase,
      'status_ppn': instance.statusppn,
      'tanggal': instance.tanggal,
      'dibuat_oleh': instance.dibuatoleh,
      'diubah_pada': instance.diubahpada,
      'dibuat_pada': instance.dibuatpada,
      'nomor': instance.nomor,
    };
