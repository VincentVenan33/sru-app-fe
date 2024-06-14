// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardGetDataPayload _$DashboardGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    DashboardGetDataPayload(
      action: json['action'] as String,
      filters:
          DashboardGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardGetDataPayloadToJson(
        DashboardGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
    };

DashboardGetFilter _$DashboardGetFilterFromJson(Map<String, dynamic> json) =>
    DashboardGetFilter(
      limit: json['limit'] as int,
      sort: json['sort'] as String?,
      orderby: json['order_by'] as String?,
    );

Map<String, dynamic> _$DashboardGetFilterToJson(DashboardGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'sort': instance.sort,
      'order_by': instance.orderby,
    };

DashboardGetDataResponse _$DashboardGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data:
          DashboardGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardGetDataResponseToJson(
        DashboardGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

DashboardGetDataResult _$DashboardGetDataResultFromJson(
        Map<String, dynamic> json) =>
    DashboardGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              DashboardGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardGetDataResultToJson(
        DashboardGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

DashboardGetDataContent _$DashboardGetDataContentFromJson(
        Map<String, dynamic> json) =>
    DashboardGetDataContent(
      nomor: json['nomor'] as int? ?? 0,
      nomordesktop: json['nomor_desktop'] as int? ?? 0,
      kode: json['kode'] as String? ?? "",
      tanggal: json['tanggal'] as String? ?? "",
      transaksitanggal: json['transaksi_tanggal'] as String? ?? "",
      statusppn: json['status_ppn'] as int? ?? 0,
      nomormhcustomer: json['nomormhcustomer'] as int? ?? 0,
      nomorthorderbeli: json['nomorthorderbeli'] as int? ?? 0,
      nomormhsales: json['nomormhsales'] as int? ?? 0,
      kodeext: json['kode_ext'] as String? ?? "",
      konversisatuan: json['konversi_satuan'] as String? ?? "",
      selectedsatuan: json['selected_satuan'] as String? ?? "",
      keterangan: json['keterangan'] as String? ?? "",
      catatan: json['catatan'] as String? ?? "",
      nomormhadmin: json['nomormhadmin'] as int? ?? 0,
      nomormhcabang: json['nomormhcabang'] as int? ?? 0,
      subtotal2: (json['subtotal2'] as num?)?.toDouble() ?? 0,
      ppnprosentase: json['ppn_prosentase'] as String? ?? "",
      ppnnominal: (json['ppn_nominal'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      sales: json['sales'] as String? ?? "",
      customer: json['customer'] as String? ?? "",
      diskonprosentase: json['diskon_prosentase'] as String? ?? "",
      diskonnominal: (json['diskon_nominal'] as num?)?.toDouble() ?? 0,
      um: (json['um'] as num?)?.toDouble() ?? 0,
      dpp: (json['dpp'] as num?)?.toDouble() ?? 0,
      totalbiaya: json['total_biaya'] as String? ?? "",
      islimitkredit: json['is_limit_kredit'] as String? ?? "",
      ishargaminimun: json['is_harga_minimun'] as String? ?? "",
      isaging: json['is_aging'] as String? ?? "",
      isnotaopen: json['is_nota_open'] as String? ?? "",
      ishargamaximun: json['is_harga_maximun'] as String? ?? "",
      isdiskonmaximun: json['is_diskon_maximun'] as String? ?? "",
    );

Map<String, dynamic> _$DashboardGetDataContentToJson(
    DashboardGetDataContent instance) {
  final val = <String, dynamic>{
    'nomor': instance.nomor,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nomor_desktop', instance.nomordesktop);
  val['kode'] = instance.kode;
  val['tanggal'] = instance.tanggal;
  val['transaksi_tanggal'] = instance.transaksitanggal;
  val['status_ppn'] = instance.statusppn;
  val['nomormhcustomer'] = instance.nomormhcustomer;
  writeNotNull('nomorthorderbeli', instance.nomorthorderbeli);
  val['nomormhsales'] = instance.nomormhsales;
  writeNotNull('kode_ext', instance.kodeext);
  writeNotNull('konversi_satuan', instance.konversisatuan);
  writeNotNull('selected_satuan', instance.selectedsatuan);
  val['keterangan'] = instance.keterangan;
  writeNotNull('catatan', instance.catatan);
  val['nomormhadmin'] = instance.nomormhadmin;
  val['nomormhcabang'] = instance.nomormhcabang;
  val['subtotal2'] = instance.subtotal2;
  val['ppn_prosentase'] = instance.ppnprosentase;
  val['ppn_nominal'] = instance.ppnnominal;
  val['total'] = instance.total;
  val['sales'] = instance.sales;
  val['customer'] = instance.customer;
  val['diskon_prosentase'] = instance.diskonprosentase;
  val['diskon_nominal'] = instance.diskonnominal;
  val['um'] = instance.um;
  val['dpp'] = instance.dpp;
  val['total_biaya'] = instance.totalbiaya;
  writeNotNull('is_limit_kredit', instance.islimitkredit);
  writeNotNull('is_harga_minimun', instance.ishargaminimun);
  writeNotNull('is_aging', instance.isaging);
  writeNotNull('is_nota_open', instance.isnotaopen);
  writeNotNull('is_harga_maximun', instance.ishargamaximun);
  writeNotNull('is_diskon_maximun', instance.isdiskonmaximun);
  return val;
}
