// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_order_penjualan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderJualsResponse _$GetOrderJualsResponseFromJson(
        Map<String, dynamic> json) =>
    GetOrderJualsResponse(
      code: json['code'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => OrderJual.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetOrderJualsResponseToJson(
        GetOrderJualsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ApproveOrderJualRequest _$ApproveOrderJualRequestFromJson(
        Map<String, dynamic> json) =>
    ApproveOrderJualRequest(
      nomorthorderjual: json['nomorthorderjual'] as int,
      nomoruser: json['nomoruser'] as int,
    );

Map<String, dynamic> _$ApproveOrderJualRequestToJson(
        ApproveOrderJualRequest instance) =>
    <String, dynamic>{
      'nomorthorderjual': instance.nomorthorderjual,
      'nomoruser': instance.nomoruser,
    };

ApproveOrderJualResponse _$ApproveOrderJualResponseFromJson(
        Map<String, dynamic> json) =>
    ApproveOrderJualResponse(
      code: json['code'] as int,
      message: json['message'] == null
          ? null
          : ApprovalMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApproveOrderJualResponseToJson(
        ApproveOrderJualResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

ApprovalMessage _$ApprovalMessageFromJson(Map<String, dynamic> json) =>
    ApprovalMessage(
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => SPMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ApprovalMessageToJson(ApprovalMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

SPMessage _$SPMessageFromJson(Map<String, dynamic> json) => SPMessage(
      flag: json['flag'] as int?,
      info: json['info'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SPMessageToJson(SPMessage instance) => <String, dynamic>{
      'flag': instance.flag,
      'info': instance.info,
      'message': instance.message,
    };

OrderJual _$OrderJualFromJson(Map<String, dynamic> json) => OrderJual(
      barang: json['barang'] as String,
      customer: json['customer'] as String,
      totalNota: json['total_nota'] as int,
      plafon: json['plafon'] as int,
      total: json['total'] as int,
      notaOpen: json['nota_open'] as int,
      tempo: json['tempo'] as int,
      isLimitKredit: json['is_limit_kredit'] as String?,
      isHargaMinimum: json['is_harga_minimum'] as String?,
      isAging: json['is_aging'] as String?,
      isNoteOpen: json['is_note_open'] as String?,
      isHargaMaximum: json['is_harga_maximum'] as String?,
      statusDisetujui: json['status_disetujui'] as int,
      nomorMhCustomer: json['nomormhcustomer'] as int,
      nomorMhSales: json['nomormhsales'] as int,
      sales: json['sales'] as String,
      nomorThOrderJual: json['nomorthorderjual'] as int,
    );

Map<String, dynamic> _$OrderJualToJson(OrderJual instance) => <String, dynamic>{
      'barang': instance.barang,
      'customer': instance.customer,
      'total_nota': instance.totalNota,
      'plafon': instance.plafon,
      'total': instance.total,
      'nota_open': instance.notaOpen,
      'tempo': instance.tempo,
      'is_limit_kredit': instance.isLimitKredit,
      'is_harga_minimum': instance.isHargaMinimum,
      'is_aging': instance.isAging,
      'is_note_open': instance.isNoteOpen,
      'is_harga_maximum': instance.isHargaMaximum,
      'status_disetujui': instance.statusDisetujui,
      'nomormhcustomer': instance.nomorMhCustomer,
      'nomormhsales': instance.nomorMhSales,
      'sales': instance.sales,
      'nomorthorderjual': instance.nomorThOrderJual,
    };
