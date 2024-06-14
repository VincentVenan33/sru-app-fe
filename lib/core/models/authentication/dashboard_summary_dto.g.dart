// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDashboardSummaryResponse _$GetDashboardSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    GetDashboardSummaryResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: GetDashboardSummaryResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDashboardSummaryResponseToJson(
        GetDashboardSummaryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

GetDashboardSummaryResponseData _$GetDashboardSummaryResponseDataFromJson(
        Map<String, dynamic> json) =>
    GetDashboardSummaryResponseData(
      countPermintaanMaterial: json['countPermintaanMaterial'] as int,
      countPenerimaanBarang: json['countPenerimaanBarang'] as int,
    );

Map<String, dynamic> _$GetDashboardSummaryResponseDataToJson(
        GetDashboardSummaryResponseData instance) =>
    <String, dynamic>{
      'countPermintaanMaterial': instance.countPermintaanMaterial,
      'countPenerimaanBarang': instance.countPenerimaanBarang,
    };
