// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDataPayload _$GetDataPayloadFromJson(Map<String, dynamic> json) =>
    GetDataPayload(
      action: json['action'] as String,
      filters: GetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>?)
          ?.map((e) => GetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDataPayloadToJson(GetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

GetFilter _$GetFilterFromJson(Map<String, dynamic> json) => GetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int? ?? 1,
      sort: json['sort'] as String?,
      orderby: json['order_by'] as String?,
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$GetFilterToJson(GetFilter instance) => <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'sort': instance.sort,
      'order_by': instance.orderby,
      'nomor': instance.nomor,
    };

GetSearch _$GetSearchFromJson(Map<String, dynamic> json) => GetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      concat: json['concat'] as int?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$GetSearchToJson(GetSearch instance) => <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'concat': instance.concat,
      'query': instance.query,
    };

GetDataResponse _$GetDataResponseFromJson(Map<String, dynamic> json) =>
    GetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: GetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDataResponseToJson(GetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

GetDataResult _$GetDataResultFromJson(Map<String, dynamic> json) =>
    GetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => GetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDataResultToJson(GetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

GetDataContent _$GetDataContentFromJson(Map<String, dynamic> json) =>
    GetDataContent(
      nomor: json['nomor'] as int,
      kode: json['kode'] as String,
      nama: json['nama'] as String,
      keterangan: json['keterangan'] as String? ?? "",
      nomormhgelar: json['nomormhgelar'] as int? ?? 0,
      nomormhkota: json['nomormhkota'] as int? ?? 0,
      nomormhdesa: json['nomormhdesa'] as int? ?? 0,
      nomormhrelasisales: json['nomormhrelasi_sales'] as int? ?? 0,
      nomormhtipeoutlet: json['nomormhtipeoutlet'] as int? ?? 0,
      nomormhkategoricustomer: json['nomormhkategoricustomer'] as int? ?? 0,
      nomormhkelurahan: json['nomormhkelurahan'] as int? ?? 0,
      nomormhprovinsi: json['nomormhprovinsi'] as int? ?? 0,
      nomormhkecamatan: json['nomormhkecamatan'] as int? ?? 0,
      kontak: json['kontak'] as String? ?? "",
      alamatktp: json['alamat_ktp'] as String? ?? "",
      shareloc: json['share_loc'] as String? ?? "",
      jatuhtempo: json['jatuh_tempo'] as int? ?? 0,
      plafon: json['plafon'] as int? ?? 0,
      npwp: json['npwp'] as String? ?? "",
      ktp: json['ktp'] as String? ?? "",
      tanggaleditplafon: json['tanggal_edit_plafon'] as String? ?? "",
      alamat: json['alamat'] as String? ?? "",
      telepon: json['telepon'] as String? ?? "",
      nohp: json['no_hp'] as String? ?? "",
      hp: json['hp'] as String? ?? "",
      gelar: json['gelar'] as String? ?? "",
      desa: json['desa'] as String? ?? "",
      sales: json['sales'] as String? ?? "",
      tipeoutlet: json['tipeoutlet'] as String? ?? "",
      kategoricustomer: json['kategoricustomer'] as String? ?? "",
      kecamatan: json['kecamatan'] as String? ?? "",
      kota: json['kota'] as String? ?? "",
      provinsi: json['provinsi'] as String? ?? "",
      omset: json['omset'] as String? ?? "",
      total: json['total'] as int? ?? 0,
      qty: json['qty'] as int? ?? 0,
    );

Map<String, dynamic> _$GetDataContentToJson(GetDataContent instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'kode': instance.kode,
      'nama': instance.nama,
      'keterangan': instance.keterangan,
      'nomormhgelar': instance.nomormhgelar,
      'nomormhkota': instance.nomormhkota,
      'nomormhdesa': instance.nomormhdesa,
      'nomormhrelasi_sales': instance.nomormhrelasisales,
      'nomormhtipeoutlet': instance.nomormhtipeoutlet,
      'nomormhkategoricustomer': instance.nomormhkategoricustomer,
      'nomormhkelurahan': instance.nomormhkelurahan,
      'nomormhprovinsi': instance.nomormhprovinsi,
      'nomormhkecamatan': instance.nomormhkecamatan,
      'kontak': instance.kontak,
      'alamat_ktp': instance.alamatktp,
      'share_loc': instance.shareloc,
      'jatuh_tempo': instance.jatuhtempo,
      'plafon': instance.plafon,
      'npwp': instance.npwp,
      'ktp': instance.ktp,
      'tanggal_edit_plafon': instance.tanggaleditplafon,
      'alamat': instance.alamat,
      'telepon': instance.telepon,
      'no_hp': instance.nohp,
      'hp': instance.hp,
      'gelar': instance.gelar,
      'desa': instance.desa,
      'sales': instance.sales,
      'tipeoutlet': instance.tipeoutlet,
      'kategoricustomer': instance.kategoricustomer,
      'kecamatan': instance.kecamatan,
      'kota': instance.kota,
      'provinsi': instance.provinsi,
      'omset': instance.omset,
      'total': instance.total,
      'qty': instance.qty,
    };
