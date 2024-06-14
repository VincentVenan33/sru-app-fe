import 'package:json_annotation/json_annotation.dart';

part 'dashboard_summary_dto.g.dart';

@JsonSerializable()
class GetDashboardSummaryResponse {
  GetDashboardSummaryResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetDashboardSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDashboardSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDashboardSummaryResponseToJson(this);

  final int code;
  final String message;
  final GetDashboardSummaryResponseData data;
}

@JsonSerializable()
class GetDashboardSummaryResponseData {
  GetDashboardSummaryResponseData({
    required this.countPermintaanMaterial,
    required this.countPenerimaanBarang,
  });

  factory GetDashboardSummaryResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetDashboardSummaryResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetDashboardSummaryResponseDataToJson(this);

  final int countPermintaanMaterial;
  final int countPenerimaanBarang;
}
