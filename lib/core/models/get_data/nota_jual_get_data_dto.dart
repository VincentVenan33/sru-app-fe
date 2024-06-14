import 'package:json_annotation/json_annotation.dart';

part 'nota_jual_get_data_dto.g.dart';

@JsonSerializable()
class NotaJualGetDataPayload {
  NotaJualGetDataPayload({
    required this.action,
    required this.filters,
  });

  factory NotaJualGetDataPayload.fromJson(Map<String, dynamic> json) => _$NotaJualGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$NotaJualGetDataPayloadToJson(this);

  final String action;
  final NotaJualGetFilter filters;
}

@JsonSerializable()
class NotaJualGetFilter {
  NotaJualGetFilter({
    this.nomor,
  });

  factory NotaJualGetFilter.fromJson(Map<String, dynamic> json) => _$NotaJualGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$NotaJualGetFilterToJson(this);

  final int? nomor;
}

@JsonSerializable()
class NotaJualGetDataResponse {
  NotaJualGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory NotaJualGetDataResponse.fromJson(Map<String, dynamic> json) => _$NotaJualGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotaJualGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final NotaJualGetDataResult data;
}

@JsonSerializable()
class NotaJualGetDataResult {
  NotaJualGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory NotaJualGetDataResult.fromJson(Map<String, dynamic> json) => _$NotaJualGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$NotaJualGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<NotaJualGetDataContent> data;
}

@JsonSerializable()
class NotaJualGetDataContent {
  NotaJualGetDataContent({
    this.nomor = 0,
    this.nomormhpph = 0,
    this.nomormhvaluta = 0,
    this.kode = "",
    this.pph2123accounting = "",
    this.pph2123 = "",
    this.togglepph = "",
    this.tanggal = "",
    this.jatuhtempo = "",
    this.nomorthdeliveryorder = 0,
    this.nomorthorderbeli = 0,
    this.nomormhmobil = 0,
    this.nomormhrelasicustsup = 0,
    this.nomormhrelasisales = 0,
    this.nomormhrelasisopir = 0,
    this.nomormhgudangtujuan = 0,
    this.nomormhgudang = 0,
    this.pelanggan = "",
    this.pembulatan = 0,
    this.ppn = 0,
    this.keterangan = "",
    this.catatan = "",
    this.nomormhadmin = 0,
    this.nomormhcabang = 0,
    this.subtotal2 = 0,
    this.terbayar = 0,
    this.ppnprosentase = "",
    this.ppnnominal = 0,
    this.total = 0,
    this.totalbiaya = "",
    this.diskonprosentase = "",
    this.um = 0,
    this.dpp = 0,
    this.statusppn = 0,
    this.jenis = "",
    this.saldoawal = 0,
    this.subtotal = "",
    this.nomormhproviderdebit = 0,
    this.nomormhproviderkredit = 0,
    this.nomormhproviderkredit2 = 0,
    this.ratedebit = "",
    this.ratekredit = "",
    this.ratekredit2 = "",
    this.bayardebit = "",
    this.bayargesekdebit = "",
    this.bayarkredit = "",
    this.bayargesekkredit = "",
    this.bayarkredit2 = "",
    this.bayargesekkredit2 = "",
    this.statusberangkat = 0,
    this.waktuberangkat = "",
    this.latitudeberangkat = "",
    this.longitudeberangkat = "",
    this.userberangkat = 0,
    this.statussampai = 0,
    this.waktusampai = "",
    this.latitudesampai = "",
    this.longitudesampai = "",
    this.usersampai = 0,
    this.statusdatang = 0,
    this.waktudatang = "",
    this.latitudedatang = "",
    this.longitudedatang = "",
    this.userdatang = 0,
    this.kodecustomer = "",
    this.sales = "",
    this.customer = "",
    this.statuskirim = "",
    this.statusapproval = "",
    this.qty = 0,
  });

  factory NotaJualGetDataContent.fromJson(Map<String, dynamic> json) => _$NotaJualGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$NotaJualGetDataContentToJson(this);

  final int? nomor;
  final int? nomormhpph;
  final int? nomormhvaluta;
  final String? kode;
  @JsonKey(name: 'pph21_23_accounting')
  final String? pph2123accounting;
  @JsonKey(name: 'pph21_23')
  final String? pph2123;
  @JsonKey(name: 'toggle_pph')
  final String? togglepph;
  final String? tanggal;
  @JsonKey(name: 'jatuh_tempo')
  final String? jatuhtempo;
  final int? nomorthdeliveryorder;
  final int? nomorthorderbeli;
  final int? nomormhmobil;
  @JsonKey(name: 'nomormhrelasi_cust_sup')
  final int? nomormhrelasicustsup;
  @JsonKey(name: 'nomormhrelasi_sales')
  final int? nomormhrelasisales;
  @JsonKey(name: 'nomormhrelasi_sopir')
  final int? nomormhrelasisopir;
  @JsonKey(name: 'nomormhgudang_tujuan')
  final int? nomormhgudangtujuan;
  final int? nomormhgudang;
  final String? pelanggan;
  final int? pembulatan;
  final int? ppn;
  final String? keterangan;
  final String? catatan;
  final int? nomormhadmin;
  final int? nomormhcabang;
  final int? subtotal2;
  @JsonKey(name: 'ppn_prosentase')
  final String? ppnprosentase;
  @JsonKey(name: 'ppn_nominal')
  final int? ppnnominal;
  final int? total;
  @JsonKey(name: 'total_biaya')
  final String? totalbiaya;
  @JsonKey(name: 'diskon_prosentase')
  final String? diskonprosentase;
  final int? um;
  final int? dpp;
  final int? terbayar;
  @JsonKey(name: 'status_ppn')
  final int? statusppn;
  final String? jenis;
  @JsonKey(name: 'saldo_awal')
  final int? saldoawal;
  final String? subtotal;
  final int? nomormhproviderdebit;
  final int? nomormhproviderkredit;
  @JsonKey(name: 'nomormhproviderkredit_2')
  final int? nomormhproviderkredit2;
  @JsonKey(name: 'rate_debit')
  final String? ratedebit;
  @JsonKey(name: 'rate_kredit')
  final String? ratekredit;
  @JsonKey(name: 'rate_kredit_2')
  final String? ratekredit2;
  @JsonKey(name: 'bayar_debit')
  final String? bayardebit;
  @JsonKey(name: 'bayar_gesek_debit')
  final String? bayargesekdebit;
  @JsonKey(name: 'bayar_kredit')
  final String? bayarkredit;
  @JsonKey(name: 'bayar_gesek_kredit')
  final String? bayargesekkredit;
  @JsonKey(name: 'bayar_kredit_2')
  final String? bayarkredit2;
  @JsonKey(name: 'bayar_gesek_kredit_2')
  final String? bayargesekkredit2;
  @JsonKey(name: 'status_berangkat')
  final int? statusberangkat;
  @JsonKey(name: 'waktu_berangkat')
  final String? waktuberangkat;
  @JsonKey(name: 'latitude_berangkat')
  final String? latitudeberangkat;
  @JsonKey(name: 'longitude_berangkat')
  final String? longitudeberangkat;
  @JsonKey(name: 'user_berangkat')
  final int? userberangkat;
  @JsonKey(name: 'status_sampai')
  final int? statussampai;
  @JsonKey(name: 'waktu_sampai')
  final String? waktusampai;
  @JsonKey(name: 'latitude_sampai')
  final String? latitudesampai;
  @JsonKey(name: 'longitude_sampai')
  final String? longitudesampai;
  @JsonKey(name: 'user_sampai')
  final int? usersampai;
  @JsonKey(name: 'status_datang')
  final int? statusdatang;
  @JsonKey(name: 'waktu_datang')
  final String? waktudatang;
  @JsonKey(name: 'latitude_datang')
  final String? latitudedatang;
  @JsonKey(name: 'longitude_datang')
  final String? longitudedatang;
  @JsonKey(name: 'user_datang')
  final int? userdatang;
  final String? kodecustomer;
  final String? sales;
  final String? customer;
  @JsonKey(name: 'status_kirim')
  final String? statuskirim;
  @JsonKey(name: 'status_approval')
  final String? statusapproval;
  final int? qty;
}
