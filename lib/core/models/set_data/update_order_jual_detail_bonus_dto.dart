import 'package:json_annotation/json_annotation.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_detail_bonus_dto.dart';

part 'update_order_jual_detail_bonus_dto.g.dart';

@JsonSerializable()
class UpdateOrderJualDetailBonusPayload {
  UpdateOrderJualDetailBonusPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateOrderJualDetailBonusPayload.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualDetailBonusPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailBonusPayloadToJson(this);

  final String action;
  final UpdateOrderJualDetailBonusRequest requestData;
}

@JsonSerializable()
class UpdateOrderJualDetailBonusRequest {
  UpdateOrderJualDetailBonusRequest({
    required this.nomormhcustomer,
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
    required this.detail,
  });

  factory UpdateOrderJualDetailBonusRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualDetailBonusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailBonusRequestToJson(this);

  final String nomormhcustomer;
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
  final List<CreateDetailRequest> detail;
}

@JsonSerializable()
class UpdateDetailRequest {
  UpdateDetailRequest({
    required this.orderjualdetail,
    // this.orderjualbonusdetail,
  });

  factory UpdateDetailRequest.fromJson(Map<String, dynamic> json) => _$UpdateDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDetailRequestToJson(this);

  @JsonKey(name: 'order_jual_detail')
  final List<UpdateOrderJualDetailRequest> orderjualdetail;
  // @JsonKey(name: 'order_jual_bonus_detail')
  // final List<UpdateOrderJualBonusDetailRequest>? orderjualbonusdetail;
}

// @JsonSerializable()
// class UpdateOrderJualDetailContent {
//   UpdateOrderJualDetailContent({
//     required this.orderjualdetailrequest,
//   });

//   factory UpdateOrderJualDetailContent.fromJson(Map<String, dynamic> json) =>
//       _$UpdateOrderJualDetailContentFromJson(json);

//   Map<String, dynamic> toJson() => _$UpdateOrderJualDetailContentToJson(this);

//   final UpdateOrderJualDetailRequest orderjualdetailrequest;
// }

@JsonSerializable()
class UpdateOrderJualDetailRequest {
  UpdateOrderJualDetailRequest({
    this.nomor,
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

  factory UpdateOrderJualDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailRequestToJson(this);
  final int? nomor;
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
// class UpdateOrderJualBonusDetailContent {
//   UpdateOrderJualBonusDetailContent({
//     required this.orderjualbonusdetailrequest,
//   });

//   factory UpdateOrderJualBonusDetailContent.fromJson(Map<String, dynamic> json) =>
//       _$UpdateOrderJualBonusDetailContentFromJson(json);

//   Map<String, dynamic> toJson() => _$UpdateOrderJualBonusDetailContentToJson(this);

//   @JsonKey(name: 'order_jual_detail')
//   final UpdateOrderJualBonusDetailRequest orderjualbonusdetailrequest;
// }

@JsonSerializable()
class UpdateOrderJualBonusDetailRequest {
  UpdateOrderJualBonusDetailRequest({
    this.nomor,
    required this.nomormhbarang,
    required this.nomormhsatuan,
    required this.qtyunit,
    required this.satuanunit,
    required this.qtyisi,
    required this.satuanisi,
    required this.konversisatuan,
    required this.selectedsatuan,
  });

  factory UpdateOrderJualBonusDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualBonusDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualBonusDetailRequestToJson(this);

  final int? nomor;
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
  final SetUpdateOrderJualDetailDataContent data;
}

@JsonSerializable()
class SetUpdateOrderJualDetailDataContent {
  SetUpdateOrderJualDetailDataContent({
    required this.kode,
    required this.nomormhrelasicust,
    required this.nomormhrelasisales,
    required this.nomormhcustomer,
    required this.ppnprosentase,
    required this.statusppn,
    required this.tanggal,
    required this.dibuatoleh,
    required this.diubahpada,
    required this.dibuatpada,
    required this.nomor,
  });

  factory SetUpdateOrderJualDetailDataContent.fromJson(Map<String, dynamic> json) =>
      _$SetUpdateOrderJualDetailDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SetUpdateOrderJualDetailDataContentToJson(this);

  final String kode;
  @JsonKey(name: 'nomormhrelasi_cust')
  final String nomormhrelasicust;
  @JsonKey(name: 'nomormhrelasi_sales')
  final String nomormhrelasisales;
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
  final int nomor;
}
