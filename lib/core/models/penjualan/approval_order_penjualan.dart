import 'package:json_annotation/json_annotation.dart';

part 'approval_order_penjualan.g.dart';

@JsonSerializable()
class GetOrderJualsResponse {
  GetOrderJualsResponse({
    required this.code,
    this.message,
    required this.data,
  });

  factory GetOrderJualsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOrderJualsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrderJualsResponseToJson(this);

  final int code;
  final String? message;

  @JsonKey(defaultValue: [])
  final List<OrderJual> data;
}

@JsonSerializable()
class ApproveOrderJualRequest {
  ApproveOrderJualRequest({
    required this.nomorthorderjual,
    required this.nomoruser,
  });

  factory ApproveOrderJualRequest.fromJson(Map<String, dynamic> json) =>
      _$ApproveOrderJualRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveOrderJualRequestToJson(this);

  final int nomorthorderjual;
  final int nomoruser;
  final int mode = 0;
}

@JsonSerializable()
class ApproveOrderJualResponse {
  ApproveOrderJualResponse({
    required this.code,
    this.message,
  });

  factory ApproveOrderJualResponse.fromJson(Map<String, dynamic> json) =>
      _$ApproveOrderJualResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveOrderJualResponseToJson(this);

  final int code;
  final ApprovalMessage? message;
}

@JsonSerializable()
class ApprovalMessage {
  ApprovalMessage({
    this.message,
    this.data,
  });

  factory ApprovalMessage.fromJson(Map<String, dynamic> json) =>
      _$ApprovalMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalMessageToJson(this);

  final List<SPMessage>? message;
  final List<String>? data;
}

@JsonSerializable()
class SPMessage {
  SPMessage({
    this.flag,
    this.info,
    this.message,
  });

  factory SPMessage.fromJson(Map<String, dynamic> json) =>
      _$SPMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SPMessageToJson(this);

  final int? flag;
  final String? info;
  final String? message;
}

@JsonSerializable()
class OrderJual {
  OrderJual({
    required this.barang,
    required this.customer,
    required this.totalNota,
    required this.plafon,
    required this.total,
    required this.notaOpen,
    required this.tempo,
    this.isLimitKredit,
    this.isHargaMinimum,
    this.isAging,
    required this.isNoteOpen,
    required this.isHargaMaximum,
    required this.statusDisetujui,
    required this.nomorMhCustomer,
    required this.nomorMhSales,
    required this.sales,
    required this.nomorThOrderJual,
  });

  factory OrderJual.fromJson(Map<String, dynamic> json) =>
      _$OrderJualFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualToJson(this);

  final String barang;
  final String customer;
  @JsonKey(name: 'total_nota')
  final int totalNota;
  final int plafon;
  final int total;
  @JsonKey(name: 'nota_open')
  final int notaOpen;
  final int tempo;
  @JsonKey(name: 'is_limit_kredit')
  final String? isLimitKredit;
  @JsonKey(name: 'is_harga_minimum')
  final String? isHargaMinimum;
  @JsonKey(name: 'is_aging')
  final String? isAging;
  @JsonKey(name: 'is_note_open')
  final String? isNoteOpen;
  @JsonKey(name: 'is_harga_maximum')
  final String? isHargaMaximum;
  @JsonKey(name: 'status_disetujui')
  final int statusDisetujui;
  @JsonKey(name: 'nomormhcustomer')
  final int nomorMhCustomer;
  @JsonKey(name: 'nomormhsales')
  final int nomorMhSales;

  final String sales;

  @JsonKey(name: 'nomorthorderjual')
  final int nomorThOrderJual;
}
