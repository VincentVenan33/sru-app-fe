// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_jual_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderJualGetDataPayload _$OrderJualGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataPayload(
      action: json['action'] as String,
      filters:
          OrderJualGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>)
          .map((e) => OrderJualGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderJualGetDataPayloadToJson(
        OrderJualGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

OrderJualGetFilter _$OrderJualGetFilterFromJson(Map<String, dynamic> json) =>
    OrderJualGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int,
      sort: json['sort'] as String?,
      nomor: json['nomor'] as int?,
      orderby: json['order_by'] as String?,
    );

Map<String, dynamic> _$OrderJualGetFilterToJson(OrderJualGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'nomor': instance.nomor,
      'sort': instance.sort,
      'order_by': instance.orderby,
    };

OrderJualGetSearch _$OrderJualGetSearchFromJson(Map<String, dynamic> json) =>
    OrderJualGetSearch(
      term: json['term'] as String?,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$OrderJualGetSearchToJson(OrderJualGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

OrderJualGetDataResponse _$OrderJualGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data:
          OrderJualGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderJualGetDataResponseToJson(
        OrderJualGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

OrderJualGetDataResult _$OrderJualGetDataResultFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              OrderJualGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderJualGetDataResultToJson(
        OrderJualGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

OrderJualGetDataContent _$OrderJualGetDataContentFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataContent(
      nomor: json['nomor'] as int? ?? 0,
      nomordesktop: json['nomor_desktop'] as int? ?? 0,
      nomorthorderjual: json['nomorthorderjual'] as int? ?? 0,
      kode: json['kode'] as String? ?? "",
      kodebarang: json['kodebarang'] as String? ?? "",
      tanggal: json['tanggal'] as String? ?? "",
      transaksitanggal: json['transaksi_tanggal'] as String? ?? "",
      statusppn: json['status_ppn'] as int? ?? 0,
      nomormhrelasicust: json['nomormhrelasi_cust'] as int? ?? 0,
      nomorthorderbeli: json['nomorthorderbeli'] as int? ?? 0,
      nomormhrelasisales: json['nomormhrelasi_sales'] as int? ?? 0,
      nomormhbarang: json['nomormhbarang'] as int? ?? 0,
      nomormhsatuan: json['nomormhsatuan'] as int? ?? 0,
      kodeext: json['kode_ext'] as String? ?? "",
      konversisatuan: json['konversi_satuan'] as String? ?? "",
      selectedsatuan: json['selected_satuan'] as int? ?? 1,
      keterangan: json['keterangan'] as String? ?? "",
      catatan: json['catatan'] as String? ?? "",
      nomormhadmin: json['nomormhadmin'] as int? ?? 0,
      nomormhcabang: json['nomormhcabang'] as int? ?? 0,
      subtotal2: json['subtotal2'] as int? ?? 0,
      ppnprosentase: json['ppn_prosentase'] as String? ?? "",
      ppnnominal: json['ppn_nominal'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      sales: json['sales'] as String? ?? "",
      customer: json['customer'] as String? ?? "",
      diskonprosentase: json['diskon_prosentase'] as String? ?? "",
      diskonnominal: json['diskon_nominal'] as int? ?? 0,
      um: json['um'] as int? ?? 0,
      dpp: json['dpp'] as int? ?? 0,
      totalbiaya: json['total_biaya'] as String? ?? "",
      islimitkredit: json['is_limit_kredit'] as String? ?? "",
      ishargaminimun: json['is_harga_minimun'] as String? ?? "",
      isaging: json['is_aging'] as String? ?? "",
      isnotaopen: json['is_nota_open'] as String? ?? "",
      ishargamaximun: json['is_harga_maximun'] as String? ?? "",
      isdiskonmaximun: json['is_diskon_maximun'] as String? ?? "",
      qty: json['qty'] as int? ?? 0,
      statusapproval: json['status_approval'] as String? ?? "",
      kodecustomer: json['kodecustomer'] as String? ?? "",
      qtyterdo: json['qty_terdo'] as String? ?? "",
      netto: json['netto'] as int? ?? 0,
      disctotal: json['disc_total'] as int? ?? 0,
      discdirect: json['disc_direct'] as int? ?? 0,
      disc3: json['disc_3'] as int? ?? 0,
      disc2: json['disc_2'] as int? ?? 0,
      disc1: json['disc_1'] as int? ?? 0,
      satuanqty: json['satuan_qty'] as String? ?? "",
      isi: json['isi'] as int? ?? 0,
      satuanisi: json['satuan_isi'] as String? ?? "",
      harga: json['harga'] as int? ?? 0,
      subtotal: json['subtotal'] as int? ?? 0,
      maxdisc: json['max_disc'] as String? ?? "",
      barang: json['barang'] as String? ?? "",
      satuan: json['satuan'] as String? ?? "",
      qtyunit: json['qty_unit'] as String? ?? "",
      satuanunit: json['satuan_unit'] as String? ?? "",
      qtyisi: json['qty_isi'] as String? ?? "",
      statusdisetujui: json['status_disetujui'] as int? ?? 0,
      statusdelivery: json['status_delivery'] as String? ?? "",
    );

Map<String, dynamic> _$OrderJualGetDataContentToJson(
    OrderJualGetDataContent instance) {
  final val = <String, dynamic>{
    'nomor': instance.nomor,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nomor_desktop', instance.nomordesktop);
  val['nomorthorderjual'] = instance.nomorthorderjual;
  val['kode'] = instance.kode;
  val['kodebarang'] = instance.kodebarang;
  val['tanggal'] = instance.tanggal;
  val['transaksi_tanggal'] = instance.transaksitanggal;
  val['status_ppn'] = instance.statusppn;
  writeNotNull('nomormhrelasi_cust', instance.nomormhrelasicust);
  writeNotNull('nomorthorderbeli', instance.nomorthorderbeli);
  writeNotNull('nomormhrelasi_sales', instance.nomormhrelasisales);
  writeNotNull('kode_ext', instance.kodeext);
  writeNotNull('konversi_satuan', instance.konversisatuan);
  writeNotNull('selected_satuan', instance.selectedsatuan);
  val['keterangan'] = instance.keterangan;
  writeNotNull('catatan', instance.catatan);
  val['nomormhadmin'] = instance.nomormhadmin;
  val['nomormhcabang'] = instance.nomormhcabang;
  val['nomormhbarang'] = instance.nomormhbarang;
  val['nomormhsatuan'] = instance.nomormhsatuan;
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
  val['qty'] = instance.qty;
  writeNotNull('status_approval', instance.statusapproval);
  val['kodecustomer'] = instance.kodecustomer;
  writeNotNull('qty_terdo', instance.qtyterdo);
  val['netto'] = instance.netto;
  writeNotNull('disc_total', instance.disctotal);
  writeNotNull('disc_direct', instance.discdirect);
  writeNotNull('disc_3', instance.disc3);
  writeNotNull('disc_2', instance.disc2);
  writeNotNull('disc_1', instance.disc1);
  writeNotNull('satuan_qty', instance.satuanqty);
  val['isi'] = instance.isi;
  writeNotNull('satuan_isi', instance.satuanisi);
  val['harga'] = instance.harga;
  val['subtotal'] = instance.subtotal;
  writeNotNull('max_disc', instance.maxdisc);
  val['barang'] = instance.barang;
  val['satuan'] = instance.satuan;
  writeNotNull('qty_unit', instance.qtyunit);
  writeNotNull('satuan_unit', instance.satuanunit);
  writeNotNull('qty_isi', instance.qtyisi);
  writeNotNull('status_disetujui', instance.statusdisetujui);
  writeNotNull('status_delivery', instance.statusdelivery);
  return val;
}
