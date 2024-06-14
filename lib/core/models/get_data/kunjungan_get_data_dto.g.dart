// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kunjungan_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KunjunganGetDataPayload _$KunjunganGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    KunjunganGetDataPayload(
      action: json['action'] as String,
      filters:
          KunjunganGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>)
          .map((e) => KunjunganGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KunjunganGetDataPayloadToJson(
        KunjunganGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

KunjunganGetFilter _$KunjunganGetFilterFromJson(Map<String, dynamic> json) =>
    KunjunganGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int? ?? 1,
      sort: json['sort'] as String?,
      orderby: json['order_by'] as String?,
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$KunjunganGetFilterToJson(KunjunganGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'sort': instance.sort,
      'order_by': instance.orderby,
      'nomor': instance.nomor,
    };

KunjunganGetSearch _$KunjunganGetSearchFromJson(Map<String, dynamic> json) =>
    KunjunganGetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$KunjunganGetSearchToJson(KunjunganGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

KunjunganGetDataResponse _$KunjunganGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    KunjunganGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data:
          KunjunganGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KunjunganGetDataResponseToJson(
        KunjunganGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

KunjunganGetDataResult _$KunjunganGetDataResultFromJson(
        Map<String, dynamic> json) =>
    KunjunganGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              KunjunganGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KunjunganGetDataResultToJson(
        KunjunganGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

KunjunganGetDataContent _$KunjunganGetDataContentFromJson(
        Map<String, dynamic> json) =>
    KunjunganGetDataContent(
      nomor: json['nomor'] as int,
      kode: json['kode'] as String,
      nomormhcustomer: json['nomormhcustomer'] as int? ?? 1,
      nomormhsales: json['nomormhsales'] as int? ?? 1,
      tanggal: json['tanggal'] as String? ?? "",
      waktuin: json['waktu_in'] as String? ?? "",
      waktucheckin: json['waktu_check_in'] as String? ?? "",
      waktuout: json['waktu_out'] as String? ?? "",
      waktucheckout: json['waktu_check_out'] as String? ?? "",
      keterangan: json['keterangan'] as String? ?? "",
      judul: json['judul'] as String? ?? "",
      rencana: json['rencana'] as String? ?? "",
      gambar: json['gambar'] as String? ?? "",
      latitude: json['latitude'] as String? ?? "",
      longitude: json['longitude'] as String? ?? "",
      statuscheckin: json['status_check_in'] as int? ?? 0,
      statuscheckout: json['status_check_out'] as int? ?? 0,
      catatan: json['catatan'] as String? ?? "",
      alasanvalidasi: json['alasan_validasi'] as String? ?? "",
      alasanunvalidasi: json['alasan_unvalidasi'] as String? ?? "",
      alamat: json['alamat'] as String? ?? "",
      customer: json['customer'] as String? ?? "",
      sales: json['sales'] as String? ?? "",
      statuskunjungan: json['status_kunjungan'] as String? ?? "",
      total: json['total'] as int? ?? 0,
      qty: json['qty'] as int? ?? 0,
    );

Map<String, dynamic> _$KunjunganGetDataContentToJson(
        KunjunganGetDataContent instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'kode': instance.kode,
      'nomormhcustomer': instance.nomormhcustomer,
      'nomormhsales': instance.nomormhsales,
      'tanggal': instance.tanggal,
      'waktu_in': instance.waktuin,
      'waktu_check_in': instance.waktucheckin,
      'waktu_out': instance.waktuout,
      'waktu_check_out': instance.waktucheckout,
      'keterangan': instance.keterangan,
      'judul': instance.judul,
      'rencana': instance.rencana,
      'gambar': instance.gambar,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status_check_in': instance.statuscheckin,
      'status_check_out': instance.statuscheckout,
      'catatan': instance.catatan,
      'alasan_validasi': instance.alasanvalidasi,
      'alasan_unvalidasi': instance.alasanunvalidasi,
      'alamat': instance.alamat,
      'customer': instance.customer,
      'sales': instance.sales,
      'status_kunjungan': instance.statuskunjungan,
      'total': instance.total,
      'qty': instance.qty,
    };
