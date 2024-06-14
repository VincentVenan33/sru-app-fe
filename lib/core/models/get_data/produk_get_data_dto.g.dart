// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarangGetDataPayload _$BarangGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    BarangGetDataPayload(
      action: json['action'] as String,
      filters:
          BarangGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>)
          .map((e) => BarangGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
      sort: json['sort'] as String,
      orderby: json['order_by'] as String,
    );

Map<String, dynamic> _$BarangGetDataPayloadToJson(
        BarangGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
      'sort': instance.sort,
      'order_by': instance.orderby,
    };

BarangGetFilter _$BarangGetFilterFromJson(Map<String, dynamic> json) =>
    BarangGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int,
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$BarangGetFilterToJson(BarangGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'nomor': instance.nomor,
    };

BarangGetSearch _$BarangGetSearchFromJson(Map<String, dynamic> json) =>
    BarangGetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$BarangGetSearchToJson(BarangGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

BarangGetDataResponse _$BarangGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    BarangGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: BarangGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BarangGetDataResponseToJson(
        BarangGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

BarangGetDataResult _$BarangGetDataResultFromJson(Map<String, dynamic> json) =>
    BarangGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => BarangGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarangGetDataResultToJson(
        BarangGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

BarangGetDataContent _$BarangGetDataContentFromJson(
        Map<String, dynamic> json) =>
    BarangGetDataContent(
      nomor: json['nomor'] as int,
      kode: json['kode'] as String,
      nama: json['nama'] as String,
      nomormhmerkbarang: json['nomormhmerkbarang'] as int? ?? 0,
      varian: json['varian'] as String? ?? "",
      nomormhgolonganbarang: json['nomormhgolonganbarang'] as int? ?? 0,
      nomormhkategoribarang: json['nomormhkategoribarang'] as int? ?? 0,
      nomormhsubstitusibarang: json['nomormhsubstitusibarang'] as int? ?? 0,
      nomormhjenispenjualan: json['nomormhjenispenjualan'] as int? ?? 0,
      nomormhgroupbarang: json['nomormhgroupbarang'] as int? ?? 0,
      nomormhsatuan1: json['nomormhsatuan1'] as int? ?? 0,
      nomormhsatuan2: json['nomormhsatuan2'] as int? ?? 0,
      nomormhsatuan3: json['nomormhsatuan3'] as int? ?? 0,
      nomormhprincipal: json['nomormhprincipal'] as int? ?? 0,
      berat: json['berat'] as String? ?? "",
      konversisatuan2: json['konversi_satuan_2'] as int? ?? 0,
      konversisatuan3: json['konversi_satuan_3'] as int? ?? 0,
      komisi: json['komisi'] as int? ?? 0,
      bonus: json['bonus'] as String? ?? "",
      hargapricelist: json['hargapricelist'] as String? ?? "",
      hargadasar: json['harga_dasar'] as String? ?? "",
      hargaterendah: json['harga_terendah'] as String? ?? "",
      minimumstok: json['minimum_stok'] as int? ?? 0,
      maximumstok: json['maximum_stok'] as int? ?? 0,
      expdate: json['exp_date'] as String? ?? "",
      eod: json['eod'] as String? ?? "",
      keterangan: json['keterangan'] as String? ?? "",
      catatan: json['catatan'] as String? ?? "",
      directory: json['directory'] as String? ?? "",
      kategoribarang: json['kategoribarang'] as String? ?? "",
      satuan1: json['satuan1'] as String? ?? "",
      satuan2: json['satuan2'] as String? ?? "",
      satuan3: json['satuan3'] as String? ?? "",
      substitusibarang: json['substitusibarang'] as String? ?? "",
      jenispenjualan: json['jenispenjualan'] as String? ?? "",
      golonganbarang: json['golonganbarang'] as String? ?? "",
      groupbarang: json['groupbarang'] as String? ?? "",
      total: json['total'] as int? ?? 0,
      qty: json['qty'] as int? ?? 0,
    );

Map<String, dynamic> _$BarangGetDataContentToJson(
    BarangGetDataContent instance) {
  final val = <String, dynamic>{
    'nomor': instance.nomor,
    'kode': instance.kode,
    'nama': instance.nama,
    'nomormhmerkbarang': instance.nomormhmerkbarang,
    'varian': instance.varian,
    'nomormhgolonganbarang': instance.nomormhgolonganbarang,
    'nomormhkategoribarang': instance.nomormhkategoribarang,
    'nomormhsubstitusibarang': instance.nomormhsubstitusibarang,
    'nomormhjenispenjualan': instance.nomormhjenispenjualan,
    'nomormhgroupbarang': instance.nomormhgroupbarang,
    'nomormhsatuan1': instance.nomormhsatuan1,
    'nomormhsatuan2': instance.nomormhsatuan2,
    'nomormhsatuan3': instance.nomormhsatuan3,
    'nomormhprincipal': instance.nomormhprincipal,
    'berat': instance.berat,
    'konversi_satuan_2': instance.konversisatuan2,
    'konversi_satuan_3': instance.konversisatuan3,
    'komisi': instance.komisi,
    'bonus': instance.bonus,
    'hargapricelist': instance.hargapricelist,
    'harga_dasar': instance.hargadasar,
    'harga_terendah': instance.hargaterendah,
    'minimum_stok': instance.minimumstok,
    'maximum_stok': instance.maximumstok,
    'exp_date': instance.expdate,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('eod', instance.eod);
  val['keterangan'] = instance.keterangan;
  writeNotNull('catatan', instance.catatan);
  val['directory'] = instance.directory;
  val['kategoribarang'] = instance.kategoribarang;
  val['satuan1'] = instance.satuan1;
  val['satuan2'] = instance.satuan2;
  val['satuan3'] = instance.satuan3;
  val['substitusibarang'] = instance.substitusibarang;
  val['jenispenjualan'] = instance.jenispenjualan;
  val['golonganbarang'] = instance.golonganbarang;
  val['groupbarang'] = instance.groupbarang;
  val['total'] = instance.total;
  val['qty'] = instance.qty;
  return val;
}
