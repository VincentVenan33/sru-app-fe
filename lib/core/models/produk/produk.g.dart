// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProdukResponse _$GetProdukResponseFromJson(Map<String, dynamic> json) =>
    GetProdukResponse(
      code: json['code'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Produk.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetProdukResponseToJson(GetProdukResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Produk _$ProdukFromJson(Map<String, dynamic> json) => Produk(
      kode: json['kode'] as String,
      nama: json['nama'] as String,
      berat: json['berat'] as String,
      bonus: json['bonus'] as String,
      golongan: json['golongan'] as String,
      jenispenjualan: json['jenis_penjualan'] as String,
      groupbarang: json['group_barang'] as String,
      satuan: json['satuan'] as String,
      supplier: json['supplier'] as String?,
    );

Map<String, dynamic> _$ProdukToJson(Produk instance) => <String, dynamic>{
      'kode': instance.kode,
      'nama': instance.nama,
      'berat': instance.berat,
      'bonus': instance.bonus,
      'golongan': instance.golongan,
      'jenis_penjualan': instance.jenispenjualan,
      'group_barang': instance.groupbarang,
      'satuan': instance.satuan,
      'supplier': instance.supplier,
    };
