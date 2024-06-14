// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCustomerPayload _$UpdateCustomerPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateCustomerPayload(
      action: json['action'] as String,
      requestData:
          UpdateRequest.fromJson(json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateCustomerPayloadToJson(
        UpdateCustomerPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateRequest _$UpdateRequestFromJson(Map<String, dynamic> json) =>
    UpdateRequest(
      nomormhdesa: json['nomormhdesa'] as int?,
      nomormhkategoricustomer: json['nomormhkategoricustomer'] as int?,
      nomormhtipeoutlet: json['nomormhtipeoutlet'] as int?,
      nomormhgelar: json['nomormhgelar'] as int?,
      nomormhrelasisales: json['nomormhrelasi_sales'] as int?,
      nomormhprovinsi: json['nomormhprovinsi'] as int?,
      nomormhkota: json['nomormhkota'] as int?,
      nomormhkecamatan: json['nomormhkecamatan'] as int?,
      jenis: json['jenis'] as int?,
      nama: json['nama'] as String,
      jatuhtempo: json['jatuh_tempo'] as String,
      plafon: json['plafon'] as String,
      alamat: json['alamat'] as String,
      alamatktp: json['alamat_ktp'] as String,
      shareloc: json['share_loc'] as String,
      nohp: json['no_hp'] as String,
      hp: json['hp'] as String,
      ktp: json['ktp'] as String,
      npwp: json['npwp'] as String,
      kontak: json['kontak'] as String,
      keterangan: json['keterangan'] as String?,
      diubaholeh: json['diubah_oleh'] as int,
    );

Map<String, dynamic> _$UpdateRequestToJson(UpdateRequest instance) =>
    <String, dynamic>{
      'nomormhdesa': instance.nomormhdesa,
      'nomormhkategoricustomer': instance.nomormhkategoricustomer,
      'nomormhtipeoutlet': instance.nomormhtipeoutlet,
      'nomormhgelar': instance.nomormhgelar,
      'nomormhrelasi_sales': instance.nomormhrelasisales,
      'nomormhprovinsi': instance.nomormhprovinsi,
      'nomormhkota': instance.nomormhkota,
      'nomormhkecamatan': instance.nomormhkecamatan,
      'jenis': instance.jenis,
      'nama': instance.nama,
      'jatuh_tempo': instance.jatuhtempo,
      'plafon': instance.plafon,
      'alamat': instance.alamat,
      'alamat_ktp': instance.alamatktp,
      'share_loc': instance.shareloc,
      'no_hp': instance.nohp,
      'hp': instance.hp,
      'ktp': instance.ktp,
      'npwp': instance.npwp,
      'kontak': instance.kontak,
      'keterangan': instance.keterangan,
      'diubah_oleh': instance.diubaholeh,
    };

UpdateCustomerResponse _$UpdateCustomerResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateCustomerResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int?,
    );

Map<String, dynamic> _$UpdateCustomerResponseToJson(
        UpdateCustomerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };
