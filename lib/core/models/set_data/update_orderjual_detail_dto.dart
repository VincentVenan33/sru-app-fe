import 'package:json_annotation/json_annotation.dart';

part 'update_orderjual_detail_dto.g.dart';

@JsonSerializable()
class UpdateOrderJualDetailPayload {
  UpdateOrderJualDetailPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateOrderJualDetailPayload.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualDetailPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailPayloadToJson(this);

  final String action;
  final UpdateOrderJualDetailRequest requestData;
}

@JsonSerializable()
class UpdateOrderJualDetailRequest {
  UpdateOrderJualDetailRequest({
    required this.nomor,
    required this.nomorthorderjual,
    required this.nomormhbarang,
    required this.nomormhsatuan,
    required this.qty,
    required this.netto,
    required this.disctotal,
    required this.discdirect,
    required this.disc3,
    required this.disc2,
    required this.disc1,
    required this.satuanqty,
    required this.isi,
    required this.satuanisi,
    required this.harga,
    required this.subtotal,
    required this.konversisatuan,
    required this.diubaholeh,
  });

  factory UpdateOrderJualDetailRequest.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailRequestToJson(this);

  final int? nomor;
  final int? nomorthorderjual;
  final int? nomormhbarang;
  final int? nomormhsatuan;
  final int? qty;
  final int? netto;
  @JsonKey(name: 'disc_total')
  final int? disctotal;
  @JsonKey(name: 'disc_direct')
  final int? discdirect;
  @JsonKey(name: 'disc_3')
  final int? disc3;
  @JsonKey(name: 'disc_2')
  final int? disc2;
  @JsonKey(name: 'disc_1')
  final int? disc1;
  @JsonKey(name: 'satuan_qty')
  final String satuanqty;
  final int? isi;
  @JsonKey(name: 'satuan_isi')
  final String satuanisi;
  final int? harga;
  final int subtotal;
  @JsonKey(name: 'konversi_satuan')
  final int konversisatuan;
  @JsonKey(name: 'diubah_oleh')
  final int diubaholeh;
}

@JsonSerializable()
class UpdateOrderJualDetailResponse {
  UpdateOrderJualDetailResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory UpdateOrderJualDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int? data;
}
