import 'package:json_annotation/json_annotation.dart';
import 'package:sru/core/models/set_data/create_order_jual_detail_bonus_dto.dart';

part 'create_order_jual_dto.g.dart';

@JsonSerializable()
class CreateOrderJualPayload {
  CreateOrderJualPayload({
    required this.action,
    required this.requestData,
  });

  factory CreateOrderJualPayload.fromJson(Map<String, dynamic> json) => _$CreateOrderJualPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualPayloadToJson(this);

  final String action;
  final CreateOrderJualRequest requestData;
}

@JsonSerializable()
class CreateOrderJualRequest {
  CreateOrderJualRequest({
    required this.formatcode,
    required this.nomormhcustomer,
    required this.ppnprosentase,
    required this.statusppn,
    required this.tanggal,
    required this.kode,
    required this.dibuatoleh,
  });

  factory CreateOrderJualRequest.fromJson(Map<String, dynamic> json) => _$CreateOrderJualRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualRequestToJson(this);

  final String formatcode;
  final int nomormhcustomer;
  @JsonKey(name: 'ppn_prosentase')
  final String ppnprosentase;
  @JsonKey(name: 'status_ppn')
  final int? statusppn;
  final String tanggal;
  final String kode;
  @JsonKey(name: 'dibuat_oleh')
  final int? dibuatoleh;
}

@JsonSerializable()
class CreateOrderJualResponse {
  CreateOrderJualResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory CreateOrderJualResponse.fromJson(Map<String, dynamic> json) => _$CreateOrderJualResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final SetOrderJualDataContent data;
}

@JsonSerializable()
class SetOrderJualDataContent {
  SetOrderJualDataContent({
    required this.kode,
    required this.nomormhcustomer,
    required this.ppnprosentase,
    required this.statusppn,
    required this.tanggal,
    required this.dibuatoleh,
    required this.id,
  });

  factory SetOrderJualDataContent.fromJson(Map<String, dynamic> json) => _$SetOrderJualDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SetOrderJualDataContentToJson(this);

  final String kode;
  final int nomormhcustomer;
  @JsonKey(name: 'ppn_prosentase')
  final String ppnprosentase;
  @JsonKey(name: 'status_ppn')
  final int? statusppn;
  final String tanggal;
  @JsonKey(name: 'dibuat_oleh')
  final int? dibuatoleh;
  final int? id;
}

@JsonSerializable()
class ListDetailItem {
  ListDetailItem({
    required this.items,
  });

  factory ListDetailItem.fromJson(Map<String, dynamic> json) => _$ListDetailItemFromJson(json);

  Map<String, dynamic> toJson() => _$ListDetailItemToJson(this);

  final List<CreateOrderJualDetailRequest> items;
}

@JsonSerializable()
class DetailItem {
  DetailItem({
    required this.nomor,
    this.nama,
    required this.qty,
    required this.netto,
    required this.disctotal,
    required this.discdirect,
    required this.disc3,
    required this.disc2,
    required this.disc1,
    required this.satuanqty,
    this.satuanqtynama,
    required this.isi,
    required this.satuanisi,
    this.satuanisinama,
    required this.harga,
    required this.subtotal,
    required this.konversisatuan,
  });

  factory DetailItem.fromJson(Map<String, dynamic> json) => _$DetailItemFromJson(json);

  Map<String, dynamic> toJson() => _$DetailItemToJson(this);

  final int nomor;
  final String? nama;
  final int qty;
  final int netto;
  final int disctotal;
  final int discdirect;
  final int disc3;
  final int disc2;
  final int disc1;
  final int satuanqty;
  final String? satuanqtynama;
  final int isi;
  final int satuanisi;
  final String? satuanisinama;
  final int harga;
  final int subtotal;
  final int konversisatuan;
}
