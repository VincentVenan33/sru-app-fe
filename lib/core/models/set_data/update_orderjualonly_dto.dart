import 'package:json_annotation/json_annotation.dart';

part 'update_orderjualonly_dto.g.dart';

@JsonSerializable()
class UpdateOrderJualOnlyPayload {
  UpdateOrderJualOnlyPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateOrderJualOnlyPayload.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualOnlyPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualOnlyPayloadToJson(this);

  final String action;
  final UpdateOrderJualOnlyRequest requestData;
}

@JsonSerializable()
class UpdateOrderJualOnlyRequest {
  UpdateOrderJualOnlyRequest({
    required this.nomormhrelasicust,
    required this.ppnprosentase,
    required this.statusppn,
    required this.ppnnominal,
    required this.diskonprosentase,
    required this.diskonnominal,
    required this.dpp,
    required this.totalbiaya,
    required this.total,
    required this.subtotal2,
    required this.tanggal,
    required this.kode,
    required this.diubaholeh,
  });

  factory UpdateOrderJualOnlyRequest.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualOnlyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualOnlyRequestToJson(this);

  @JsonKey(name: 'nomormhrelasi_cust')
  final String nomormhrelasicust;
  @JsonKey(name: 'ppn_prosentase')
  final String ppnprosentase;
  @JsonKey(name: 'status_ppn')
  final int statusppn;
  @JsonKey(name: 'ppn_nominal')
  final int ppnnominal;
  @JsonKey(name: 'diskon_prosentase')
  final int diskonprosentase;
  @JsonKey(name: 'diskon_nominal')
  final int diskonnominal;
  final int dpp;
  @JsonKey(name: 'total_biaya')
  final int totalbiaya;
  final int total;
  final int subtotal2;
  final String tanggal;
  final String kode;
  @JsonKey(name: 'diubah_oleh')
  final int? diubaholeh;
}

@JsonSerializable()
class UpdateOrderJualOnlyResponse {
  UpdateOrderJualOnlyResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory UpdateOrderJualOnlyResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualOnlyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualOnlyResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int? data;
}
