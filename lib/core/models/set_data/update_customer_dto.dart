import 'package:json_annotation/json_annotation.dart';

part 'update_customer_dto.g.dart';

@JsonSerializable()
class UpdateCustomerPayload {
  UpdateCustomerPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateCustomerPayload.fromJson(Map<String, dynamic> json) => _$UpdateCustomerPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCustomerPayloadToJson(this);

  final String action;
  final UpdateRequest requestData;
}

@JsonSerializable()
class UpdateRequest {
  UpdateRequest({
    required this.nomormhdesa,
    required this.nomormhkategoricustomer,
    required this.nomormhtipeoutlet,
    required this.nomormhgelar,
    required this.nomormhrelasisales,
    required this.nomormhprovinsi,
    required this.nomormhkota,
    required this.nomormhkecamatan,
    required this.jenis,
    required this.nama,
    required this.jatuhtempo,
    required this.plafon,
    required this.alamat,
    required this.alamatktp,
    required this.shareloc,
    required this.nohp,
    required this.hp,
    required this.ktp,
    required this.npwp,
    required this.kontak,
    this.keterangan,
    required this.diubaholeh,
  });

  factory UpdateRequest.fromJson(Map<String, dynamic> json) => _$UpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRequestToJson(this);

  final int? nomormhdesa;
  final int? nomormhkategoricustomer;
  final int? nomormhtipeoutlet;
  final int? nomormhgelar;
  @JsonKey(name: 'nomormhrelasi_sales')
  final int? nomormhrelasisales;
  final int? nomormhprovinsi;
  final int? nomormhkota;
  final int? nomormhkecamatan;
  final int? jenis;
  final String nama;
  @JsonKey(name: 'jatuh_tempo')
  final String jatuhtempo;
  final String plafon;
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
  @JsonKey(name: 'diubah_oleh')
  final int diubaholeh;
}

@JsonSerializable()
class UpdateCustomerResponse {
  UpdateCustomerResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory UpdateCustomerResponse.fromJson(Map<String, dynamic> json) => _$UpdateCustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCustomerResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int? data;
}

// @JsonSerializable()
// class SetDataContent {
//   SetDataContent({
//     required this.nomor,
//     required this.nomormhusaha,
//     required this.kode,
//     required this.nama,
//     this.keterangan,
//     this.catatan,
//   });

//   factory SetDataContent.fromJson(Map<String, dynamic> json) => _$SetDataContentFromJson(json);

//   Map<String, dynamic> toJson() => _$SetDataContentToJson(this);

//   final int nomor;
//   final int? nomormhusaha;
//   final String kode;
//   final String nama;
//   final String? keterangan;
//   final String? catatan;
// }
