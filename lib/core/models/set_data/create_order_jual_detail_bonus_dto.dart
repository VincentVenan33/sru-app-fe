import 'package:json_annotation/json_annotation.dart';

part 'create_order_jual_detail_bonus_dto.g.dart';

@JsonSerializable()
class CreateOrderJualDetailBonusPayload {
  CreateOrderJualDetailBonusPayload({
    required this.action,
    required this.requestData,
  });

  factory CreateOrderJualDetailBonusPayload.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailBonusPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailBonusPayloadToJson(this);

  final String action;
  final CreateOrderJualDetailBonusRequest requestData;
}

@JsonSerializable()
class CreateOrderJualDetailBonusRequest {
  CreateOrderJualDetailBonusRequest({
    required this.formatcode,
    required this.nomormhrelasicust,
    required this.nomormhrelasisales,
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
    required this.dibuatoleh,
    required this.detail,
  });

  factory CreateOrderJualDetailBonusRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailBonusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailBonusRequestToJson(this);

  @JsonKey(name: 'format_code')
  final String formatcode;
  @JsonKey(name: 'nomormhrelasi_cust')
  final String nomormhrelasicust;
  @JsonKey(name: 'nomormhrelasi_sales')
  final String nomormhrelasisales;
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
  @JsonKey(name: 'dibuat_oleh')
  final int? dibuatoleh;
  final List<CreateDetailRequest> detail;
}

@JsonSerializable()
class CreateDetailRequest {
  CreateDetailRequest({
    required this.orderjualdetail,
    // this.orderjualbonusdetail,
  });

  factory CreateDetailRequest.fromJson(Map<String, dynamic> json) => _$CreateDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDetailRequestToJson(this);

  @JsonKey(name: 'order_jual_detail')
  final List<CreateOrderJualDetailRequest> orderjualdetail;
  // @JsonKey(name: 'order_jual_bonus_detail')
  // final List<CreateOrderJualBonusDetailRequest>? orderjualbonusdetail;
}

// @JsonSerializable()
// class CreateOrderJualDetailContent {
//   CreateOrderJualDetailContent({
//     required this.orderjualdetailrequest,
//   });

//   factory CreateOrderJualDetailContent.fromJson(Map<String, dynamic> json) =>
//       _$CreateOrderJualDetailContentFromJson(json);

//   Map<String, dynamic> toJson() => _$CreateOrderJualDetailContentToJson(this);

//   final CreateOrderJualDetailRequest orderjualdetailrequest;
// }

@JsonSerializable()
class CreateOrderJualDetailRequest {
  CreateOrderJualDetailRequest({
    required this.nomormhbarang,
    this.kode,
    this.nama,
    required this.nomormhsatuan,
    required this.qty,
    required this.netto,
    required this.disctotal,
    required this.discdirect,
    required this.disc3,
    required this.disc2,
    required this.disc1,
    this.satuanqty,
    required this.isi,
    this.satuanisi,
    required this.harga,
    required this.subtotal,
    this.konversisatuan,
  });

  factory CreateOrderJualDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailRequestToJson(this);

  final int nomormhbarang;
  final String? kode;
  final String? nama;
  final int nomormhsatuan;
  final int qty;
  final int netto;
  @JsonKey(name: 'disc_total')
  final int disctotal;
  @JsonKey(name: 'disc_direct')
  final int discdirect;
  @JsonKey(name: 'disc_3')
  final int disc3;
  @JsonKey(name: 'disc_2')
  final int disc2;
  @JsonKey(name: 'disc_1')
  final int disc1;
  @JsonKey(name: 'satuan_qty')
  final String? satuanqty;
  final int isi;
  @JsonKey(name: 'satuan_isi')
  final String? satuanisi;
  final int harga;
  final int subtotal;
  @JsonKey(name: 'konversi_satuan')
  final int? konversisatuan;
}

// @JsonSerializable()
// class CreateOrderJualBonusDetailContent {
//   CreateOrderJualBonusDetailContent({
//     required this.orderjualbonusdetailrequest,
//   });

//   factory CreateOrderJualBonusDetailContent.fromJson(Map<String, dynamic> json) =>
//       _$CreateOrderJualBonusDetailContentFromJson(json);

//   Map<String, dynamic> toJson() => _$CreateOrderJualBonusDetailContentToJson(this);

//   @JsonKey(name: 'order_jual_detail')
//   final CreateOrderJualBonusDetailRequest orderjualbonusdetailrequest;
// }

@JsonSerializable()
class CreateOrderJualBonusDetailRequest {
  CreateOrderJualBonusDetailRequest({
    required this.nomormhbarang,
    required this.nomormhsatuan,
    required this.qtyunit,
    required this.satuanunit,
    required this.qtyisi,
    required this.satuanisi,
    required this.konversisatuan,
    required this.selectedsatuan,
  });

  factory CreateOrderJualBonusDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualBonusDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualBonusDetailRequestToJson(this);

  final int nomormhbarang;
  final int nomormhsatuan;
  @JsonKey(name: 'qty_unit')
  final int qtyunit;
  @JsonKey(name: 'satuan_unit')
  final String satuanunit;
  @JsonKey(name: 'qty_isi')
  final int qtyisi;
  @JsonKey(name: 'satuan_isi')
  final String satuanisi;
  @JsonKey(name: 'konversi_satuan')
  final int konversisatuan;
  @JsonKey(name: 'selected_satuan')
  final int selectedsatuan;
}

@JsonSerializable()
class CreateOrderJualDetailResponse {
  CreateOrderJualDetailResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory CreateOrderJualDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final SetOrderJualDetailDataContent data;
}

@JsonSerializable()
class SetOrderJualDetailDataContent {
  SetOrderJualDetailDataContent({
    required this.kode,
    required this.nomormhcustomer,
    required this.ppnprosentase,
    required this.statusppn,
    required this.tanggal,
    required this.dibuatoleh,
    required this.diubahpada,
    required this.dibuatpada,
    required this.id,
  });

  factory SetOrderJualDetailDataContent.fromJson(Map<String, dynamic> json) =>
      _$SetOrderJualDetailDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SetOrderJualDetailDataContentToJson(this);

  final String kode;
  final String nomormhcustomer;
  @JsonKey(name: 'ppn_prosentase')
  final String ppnprosentase;
  @JsonKey(name: 'status_ppn')
  final int statusppn;
  final String tanggal;
  @JsonKey(name: 'dibuat_oleh')
  final int dibuatoleh;
  @JsonKey(name: 'diubah_pada')
  final String diubahpada;
  @JsonKey(name: 'dibuat_pada')
  final String dibuatpada;
  final int id;
}
