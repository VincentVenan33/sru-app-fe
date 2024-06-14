import 'package:json_annotation/json_annotation.dart';

part 'create_kunjungan_dto.g.dart';

@JsonSerializable()
class CreateKunjunganPayload {
  CreateKunjunganPayload({
    required this.action,
    required this.requestData,
  });

  factory CreateKunjunganPayload.fromJson(Map<String, dynamic> json) => _$CreateKunjunganPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateKunjunganPayloadToJson(this);

  final String action;
  final CreateKunjunganRequest requestData;
}

@JsonSerializable()
class CreateKunjunganRequest {
  CreateKunjunganRequest({
    required this.formatcode,
    required this.kode,
    required this.nomormhcustomer,
    required this.nomormhsales,
    required this.tanggal,
    required this.waktuin,
    required this.waktuout,
    required this.judul,
    required this.rencana,
    required this.gambar,
    required this.latitude,
    required this.longitude,
  });

  factory CreateKunjunganRequest.fromJson(Map<String, dynamic> json) => _$CreateKunjunganRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateKunjunganRequestToJson(this);

  @JsonKey(name: 'format_code')
  final String formatcode;
  final String kode;
  final int nomormhcustomer;
  final int nomormhsales;
  final String tanggal;
  @JsonKey(name: 'waktu_in')
  final String waktuin;
  @JsonKey(name: 'waktu_out')
  final String waktuout;
  final String judul;
  final String rencana;
  final String gambar;
  final double? latitude;
  final double? longitude;
}

@JsonSerializable()
class CreateKunjunganResponse {
  CreateKunjunganResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory CreateKunjunganResponse.fromJson(Map<String, dynamic> json) => _$CreateKunjunganResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateKunjunganResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final SetKunjunganDataContent data;
}

@JsonSerializable()
class SetKunjunganDataContent {
  SetKunjunganDataContent({
    required this.kode,
    required this.nomormhcustomer,
    required this.nomormhsales,
    required this.tanggal,
    required this.waktuin,
    required this.waktuout,
    required this.judul,
    required this.rencana,
    required this.gambar,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  factory SetKunjunganDataContent.fromJson(Map<String, dynamic> json) => _$SetKunjunganDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SetKunjunganDataContentToJson(this);

  final String kode;
  final String nomormhcustomer;
  final String nomormhsales;
  final String tanggal;
  @JsonKey(name: 'waktu_in')
  final String waktuin;
  @JsonKey(name: 'waktu_out')
  final String waktuout;
  final String judul;
  final String rencana;
  final String gambar;
  final double? latitude;
  final double? longitude;
  final int? id;
}
