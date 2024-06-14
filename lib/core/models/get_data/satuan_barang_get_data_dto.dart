import 'package:json_annotation/json_annotation.dart';

part 'satuan_barang_get_data_dto.g.dart';

@JsonSerializable()
class SatuanBarangGetDataPayload {
  SatuanBarangGetDataPayload({
    required this.action,
    required this.filters,
  });

  factory SatuanBarangGetDataPayload.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetDataPayloadToJson(this);

  final String action;
  final SatuanBarangGetFilter filters;
}

@JsonSerializable()
class SatuanBarangGetFilter {
  SatuanBarangGetFilter({
    required this.query,
  });

  factory SatuanBarangGetFilter.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetFilterToJson(this);

  final int query;
}

@JsonSerializable()
class SatuanBarangGetDataResponse {
  SatuanBarangGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory SatuanBarangGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SatuanBarangGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final List<SatuanBarangGetDataContent> data;
}

// @JsonSerializable()
// class SatuanBarangGetDataResult {
//   SatuanBarangGetDataResult({
//     required this.data,
//   });

//   factory SatuanBarangGetDataResult.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetDataResultFromJson(json);

//   Map<String, dynamic> toJson() => _$SatuanBarangGetDataResultToJson(this);

//   final List<SatuanBarangGetDataContent> data;
// }

@JsonSerializable()
class SatuanBarangGetDataContent {
  SatuanBarangGetDataContent({
    this.nama = '',
    this.nomor = 0,
    this.konversi = 0,
    this.urutan = 0,
    this.hargapricelist = 0,
    this.hargadasar = 0,
    this.hargaterendah = 0,
  });

  factory SatuanBarangGetDataContent.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetDataContentToJson(this);
  @JsonKey(name: 'nama', includeIfNull: false)
  final String? nama;
  @JsonKey(name: 'nomor', includeIfNull: false)
  final int? nomor;
  @JsonKey(name: 'konversi', includeIfNull: false)
  final int? konversi;
  @JsonKey(name: 'urutan', includeIfNull: false)
  final int? urutan;
  @JsonKey(name: 'harga_pricelist', includeIfNull: false)
  final int? hargapricelist;
  @JsonKey(name: 'harga_dasar', includeIfNull: false)
  final int? hargadasar;
  @JsonKey(name: 'harga_terendah', includeIfNull: false)
  final int? hargaterendah;
}
