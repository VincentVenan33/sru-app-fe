import 'package:json_annotation/json_annotation.dart';

part 'produk_get_data_dto.g.dart';

@JsonSerializable()
class BarangGetDataPayload {
  BarangGetDataPayload({
    required this.action,
    required this.filters,
    required this.search,
    required this.sort,
    required this.orderby,
  });

  factory BarangGetDataPayload.fromJson(Map<String, dynamic> json) => _$BarangGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataPayloadToJson(this);

  final String action;
  final BarangGetFilter filters;
  final List<BarangGetSearch> search;
  final String sort;
  @JsonKey(name: 'order_by')
  final String orderby;
}

@JsonSerializable()
class BarangGetFilter {
  BarangGetFilter({
    required this.limit,
    required this.page,
    this.nomor,
  });

  factory BarangGetFilter.fromJson(Map<String, dynamic> json) => _$BarangGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetFilterToJson(this);

  final int limit;
  final int page;
  final int? nomor;
}

@JsonSerializable()
class BarangGetSearch {
  BarangGetSearch({
    required this.term,
    this.key,
    this.query,
  });

  factory BarangGetSearch.fromJson(Map<String, dynamic> json) => _$BarangGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetSearchToJson(this);

  final String term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class BarangGetDataResponse {
  BarangGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory BarangGetDataResponse.fromJson(Map<String, dynamic> json) => _$BarangGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final BarangGetDataResult data;
}

@JsonSerializable()
class BarangGetDataResult {
  BarangGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory BarangGetDataResult.fromJson(Map<String, dynamic> json) => _$BarangGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<BarangGetDataContent> data;
}

@JsonSerializable()
class BarangGetDataContent {
  BarangGetDataContent({
    required this.nomor,
    required this.kode,
    required this.nama,
    this.nomormhmerkbarang = 0,
    this.varian = "",
    this.nomormhgolonganbarang = 0,
    this.nomormhkategoribarang = 0,
    this.nomormhsubstitusibarang = 0,
    this.nomormhjenispenjualan = 0,
    this.nomormhgroupbarang = 0,
    this.nomormhsatuan1 = 0,
    this.nomormhsatuan2 = 0,
    this.nomormhsatuan3 = 0,
    this.nomormhprincipal = 0,
    this.berat = "",
    this.konversisatuan2 = 0,
    this.konversisatuan3 = 0,
    this.komisi = 0,
    this.bonus = "",
    this.hargapricelist = "",
    this.hargadasar = "",
    this.hargaterendah = "",
    this.minimumstok = 0,
    this.maximumstok = 0,
    this.expdate = "",
    this.eod = "",
    this.keterangan = "",
    this.catatan = "",
    this.directory = "",
    this.kategoribarang = "",
    this.satuan1 = "",
    this.satuan2 = "",
    this.satuan3 = "",
    this.substitusibarang = "",
    this.jenispenjualan = "",
    this.golonganbarang = "",
    this.groupbarang = "",
    this.total = 0,
    this.qty = 0,
  });

  factory BarangGetDataContent.fromJson(Map<String, dynamic> json) => _$BarangGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataContentToJson(this);

  final int nomor;
  final String kode;
  final String nama;
  final int? nomormhmerkbarang;
  final String? varian;
  final int? nomormhgolonganbarang;
  final int? nomormhkategoribarang;
  final int? nomormhsubstitusibarang;
  final int? nomormhjenispenjualan;
  final int? nomormhgroupbarang;
  final int? nomormhsatuan1;
  final int? nomormhsatuan2;
  final int? nomormhsatuan3;
  final int? nomormhprincipal;
  final String? berat;
  @JsonKey(name: 'konversi_satuan_2')
  final int? konversisatuan2;
  @JsonKey(name: 'konversi_satuan_3')
  final int? konversisatuan3;
  final int? komisi;
  final String? bonus;
  final String? hargapricelist;
  @JsonKey(name: 'harga_dasar')
  final String? hargadasar;
  @JsonKey(name: 'harga_terendah')
  final String? hargaterendah;
  @JsonKey(name: 'minimum_stok')
  final int? minimumstok;
  @JsonKey(name: 'maximum_stok')
  final int? maximumstok;
  @JsonKey(name: 'exp_date')
  final String? expdate;
  @JsonKey(name: 'eod', includeIfNull: false)
  final String? eod;
  final String? keterangan;
  @JsonKey(name: 'catatan', includeIfNull: false)
  final String? catatan;
  final String? directory;
  final String? kategoribarang;
  final String? satuan1;
  final String? satuan2;
  final String? satuan3;
  final String? substitusibarang;
  final String? jenispenjualan;
  final String? golonganbarang;
  final String? groupbarang;
  final int? total;
  final int? qty;
}
