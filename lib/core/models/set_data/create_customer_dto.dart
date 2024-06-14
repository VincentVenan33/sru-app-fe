import 'package:json_annotation/json_annotation.dart';

part 'create_customer_dto.g.dart';

@JsonSerializable()
class CreateCustomerPayload {
  CreateCustomerPayload({
    required this.action,
    required this.requestData,
  });

  factory CreateCustomerPayload.fromJson(Map<String, dynamic> json) => _$CreateCustomerPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCustomerPayloadToJson(this);

  final String action;
  final CreateRequest requestData;
}

@JsonSerializable()
class CreateRequest {
  CreateRequest({
    required this.nomormhdesa,
    required this.nomormhkategoricustomer,
    required this.nomormhtipeoutlet,
    required this.nomormhgelar,
    required this.nomormhrelasisales,
    required this.nomormhkelurahan,
    required this.nomormhprovinsi,
    required this.nomormhkota,
    required this.nomormhkecamatan,
    required this.jenis,
    required this.kode,
    required this.nama,
    required this.jatuhtempo,
    required this.plafon,
    required this.formatcode,
    required this.alamat,
    required this.alamatktp,
    required this.shareloc,
    required this.nohp,
    required this.hp,
    required this.ktp,
    required this.npwp,
    required this.kontak,
    this.keterangan,
    required this.dibuatoleh,
  });

  factory CreateRequest.fromJson(Map<String, dynamic> json) => _$CreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestToJson(this);

  final int? nomormhdesa;
  final int? nomormhkategoricustomer;
  final int? nomormhtipeoutlet;
  final int? nomormhgelar;
  @JsonKey(name: 'nomormhrelasi_sales')
  final int? nomormhrelasisales;
  final int? nomormhkelurahan;
  final int? nomormhprovinsi;
  final int? nomormhkota;
  final int? nomormhkecamatan;
  final int? jenis;
  final String kode;
  final String nama;
  @JsonKey(name: 'jatuh_tempo')
  final String jatuhtempo;
  final String plafon;
  @JsonKey(name: 'format_code')
  final String formatcode;
  final String alamat;
  @JsonKey(name: 'alamat_ktp')
  final String alamatktp;
  @JsonKey(name: 'share_loc')
  final String shareloc;
  @JsonKey(name: 'no_hp')
  final String nohp;
  final String hp;
  final String ktp;
  final String npwp;
  final String kontak;
  final String? keterangan;
  @JsonKey(name: 'dibuat_oleh')
  final int dibuatoleh;
}

@JsonSerializable()
class CreateCustomerResponse {
  CreateCustomerResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory CreateCustomerResponse.fromJson(Map<String, dynamic> json) => _$CreateCustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCustomerResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final SetDataContent data;
}

@JsonSerializable()
class SetDataContent {
  SetDataContent({
    required this.nomor,
    required this.nomormhusaha,
    required this.kode,
    required this.nama,
    this.keterangan,
    this.catatan,
  });

  factory SetDataContent.fromJson(Map<String, dynamic> json) => _$SetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SetDataContentToJson(this);

  final int nomor;
  final int? nomormhusaha;
  final String kode;
  final String nama;
  final String? keterangan;
  final String? catatan;
}
