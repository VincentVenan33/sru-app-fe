// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_jual_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotaJualGetDataPayload _$NotaJualGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    NotaJualGetDataPayload(
      action: json['action'] as String,
      filters:
          NotaJualGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotaJualGetDataPayloadToJson(
        NotaJualGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
    };

NotaJualGetFilter _$NotaJualGetFilterFromJson(Map<String, dynamic> json) =>
    NotaJualGetFilter(
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$NotaJualGetFilterToJson(NotaJualGetFilter instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
    };

NotaJualGetDataResponse _$NotaJualGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    NotaJualGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data:
          NotaJualGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotaJualGetDataResponseToJson(
        NotaJualGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

NotaJualGetDataResult _$NotaJualGetDataResultFromJson(
        Map<String, dynamic> json) =>
    NotaJualGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => NotaJualGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotaJualGetDataResultToJson(
        NotaJualGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

NotaJualGetDataContent _$NotaJualGetDataContentFromJson(
        Map<String, dynamic> json) =>
    NotaJualGetDataContent(
      nomor: json['nomor'] as int? ?? 0,
      nomormhpph: json['nomormhpph'] as int? ?? 0,
      nomormhvaluta: json['nomormhvaluta'] as int? ?? 0,
      kode: json['kode'] as String? ?? "",
      pph2123accounting: json['pph21_23_accounting'] as String? ?? "",
      pph2123: json['pph21_23'] as String? ?? "",
      togglepph: json['toggle_pph'] as String? ?? "",
      tanggal: json['tanggal'] as String? ?? "",
      jatuhtempo: json['jatuh_tempo'] as String? ?? "",
      nomorthdeliveryorder: json['nomorthdeliveryorder'] as int? ?? 0,
      nomorthorderbeli: json['nomorthorderbeli'] as int? ?? 0,
      nomormhmobil: json['nomormhmobil'] as int? ?? 0,
      nomormhrelasicustsup: json['nomormhrelasi_cust_sup'] as int? ?? 0,
      nomormhrelasisales: json['nomormhrelasi_sales'] as int? ?? 0,
      nomormhrelasisopir: json['nomormhrelasi_sopir'] as int? ?? 0,
      nomormhgudangtujuan: json['nomormhgudang_tujuan'] as int? ?? 0,
      nomormhgudang: json['nomormhgudang'] as int? ?? 0,
      pelanggan: json['pelanggan'] as String? ?? "",
      pembulatan: json['pembulatan'] as int? ?? 0,
      ppn: json['ppn'] as int? ?? 0,
      keterangan: json['keterangan'] as String? ?? "",
      catatan: json['catatan'] as String? ?? "",
      nomormhadmin: json['nomormhadmin'] as int? ?? 0,
      nomormhcabang: json['nomormhcabang'] as int? ?? 0,
      subtotal2: json['subtotal2'] as int? ?? 0,
      terbayar: json['terbayar'] as int? ?? 0,
      ppnprosentase: json['ppn_prosentase'] as String? ?? "",
      ppnnominal: json['ppn_nominal'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      totalbiaya: json['total_biaya'] as String? ?? "",
      diskonprosentase: json['diskon_prosentase'] as String? ?? "",
      um: json['um'] as int? ?? 0,
      dpp: json['dpp'] as int? ?? 0,
      statusppn: json['status_ppn'] as int? ?? 0,
      jenis: json['jenis'] as String? ?? "",
      saldoawal: json['saldo_awal'] as int? ?? 0,
      subtotal: json['subtotal'] as String? ?? "",
      nomormhproviderdebit: json['nomormhproviderdebit'] as int? ?? 0,
      nomormhproviderkredit: json['nomormhproviderkredit'] as int? ?? 0,
      nomormhproviderkredit2: json['nomormhproviderkredit_2'] as int? ?? 0,
      ratedebit: json['rate_debit'] as String? ?? "",
      ratekredit: json['rate_kredit'] as String? ?? "",
      ratekredit2: json['rate_kredit_2'] as String? ?? "",
      bayardebit: json['bayar_debit'] as String? ?? "",
      bayargesekdebit: json['bayar_gesek_debit'] as String? ?? "",
      bayarkredit: json['bayar_kredit'] as String? ?? "",
      bayargesekkredit: json['bayar_gesek_kredit'] as String? ?? "",
      bayarkredit2: json['bayar_kredit_2'] as String? ?? "",
      bayargesekkredit2: json['bayar_gesek_kredit_2'] as String? ?? "",
      statusberangkat: json['status_berangkat'] as int? ?? 0,
      waktuberangkat: json['waktu_berangkat'] as String? ?? "",
      latitudeberangkat: json['latitude_berangkat'] as String? ?? "",
      longitudeberangkat: json['longitude_berangkat'] as String? ?? "",
      userberangkat: json['user_berangkat'] as int? ?? 0,
      statussampai: json['status_sampai'] as int? ?? 0,
      waktusampai: json['waktu_sampai'] as String? ?? "",
      latitudesampai: json['latitude_sampai'] as String? ?? "",
      longitudesampai: json['longitude_sampai'] as String? ?? "",
      usersampai: json['user_sampai'] as int? ?? 0,
      statusdatang: json['status_datang'] as int? ?? 0,
      waktudatang: json['waktu_datang'] as String? ?? "",
      latitudedatang: json['latitude_datang'] as String? ?? "",
      longitudedatang: json['longitude_datang'] as String? ?? "",
      userdatang: json['user_datang'] as int? ?? 0,
      kodecustomer: json['kodecustomer'] as String? ?? "",
      sales: json['sales'] as String? ?? "",
      customer: json['customer'] as String? ?? "",
      statuskirim: json['status_kirim'] as String? ?? "",
      statusapproval: json['status_approval'] as String? ?? "",
      qty: json['qty'] as int? ?? 0,
    );

Map<String, dynamic> _$NotaJualGetDataContentToJson(
        NotaJualGetDataContent instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nomormhpph': instance.nomormhpph,
      'nomormhvaluta': instance.nomormhvaluta,
      'kode': instance.kode,
      'pph21_23_accounting': instance.pph2123accounting,
      'pph21_23': instance.pph2123,
      'toggle_pph': instance.togglepph,
      'tanggal': instance.tanggal,
      'jatuh_tempo': instance.jatuhtempo,
      'nomorthdeliveryorder': instance.nomorthdeliveryorder,
      'nomorthorderbeli': instance.nomorthorderbeli,
      'nomormhmobil': instance.nomormhmobil,
      'nomormhrelasi_cust_sup': instance.nomormhrelasicustsup,
      'nomormhrelasi_sales': instance.nomormhrelasisales,
      'nomormhrelasi_sopir': instance.nomormhrelasisopir,
      'nomormhgudang_tujuan': instance.nomormhgudangtujuan,
      'nomormhgudang': instance.nomormhgudang,
      'pelanggan': instance.pelanggan,
      'pembulatan': instance.pembulatan,
      'ppn': instance.ppn,
      'keterangan': instance.keterangan,
      'catatan': instance.catatan,
      'nomormhadmin': instance.nomormhadmin,
      'nomormhcabang': instance.nomormhcabang,
      'subtotal2': instance.subtotal2,
      'ppn_prosentase': instance.ppnprosentase,
      'ppn_nominal': instance.ppnnominal,
      'total': instance.total,
      'total_biaya': instance.totalbiaya,
      'diskon_prosentase': instance.diskonprosentase,
      'um': instance.um,
      'dpp': instance.dpp,
      'terbayar': instance.terbayar,
      'status_ppn': instance.statusppn,
      'jenis': instance.jenis,
      'saldo_awal': instance.saldoawal,
      'subtotal': instance.subtotal,
      'nomormhproviderdebit': instance.nomormhproviderdebit,
      'nomormhproviderkredit': instance.nomormhproviderkredit,
      'nomormhproviderkredit_2': instance.nomormhproviderkredit2,
      'rate_debit': instance.ratedebit,
      'rate_kredit': instance.ratekredit,
      'rate_kredit_2': instance.ratekredit2,
      'bayar_debit': instance.bayardebit,
      'bayar_gesek_debit': instance.bayargesekdebit,
      'bayar_kredit': instance.bayarkredit,
      'bayar_gesek_kredit': instance.bayargesekkredit,
      'bayar_kredit_2': instance.bayarkredit2,
      'bayar_gesek_kredit_2': instance.bayargesekkredit2,
      'status_berangkat': instance.statusberangkat,
      'waktu_berangkat': instance.waktuberangkat,
      'latitude_berangkat': instance.latitudeberangkat,
      'longitude_berangkat': instance.longitudeberangkat,
      'user_berangkat': instance.userberangkat,
      'status_sampai': instance.statussampai,
      'waktu_sampai': instance.waktusampai,
      'latitude_sampai': instance.latitudesampai,
      'longitude_sampai': instance.longitudesampai,
      'user_sampai': instance.usersampai,
      'status_datang': instance.statusdatang,
      'waktu_datang': instance.waktudatang,
      'latitude_datang': instance.latitudedatang,
      'longitude_datang': instance.longitudedatang,
      'user_datang': instance.userdatang,
      'kodecustomer': instance.kodecustomer,
      'sales': instance.sales,
      'customer': instance.customer,
      'status_kirim': instance.statuskirim,
      'status_approval': instance.statusapproval,
      'qty': instance.qty,
    };
