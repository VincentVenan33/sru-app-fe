// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      kode: json['kode'] as String,
      sandi: json['sandi'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'kode': instance.kode,
      'sandi': instance.sandi,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: LoginResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      token: json['token'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      nomor: json['nomor'] as int,
      kode: json['kode'] as String,
      nama: json['nama'] as String,
      namadepan: json['nama_depan'] as String,
      namabelakang: json['nama_belakang'] as String,
      gender: json['gender'] as String,
      tgllahir: json['tgl_lahir'] as String,
      email: json['email'] as String,
      telepon: json['telepon'] as String,
      alamat: json['alamat'] as String,
      admingrup: json['admingrup'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'nomor': instance.nomor,
      'kode': instance.kode,
      'nama': instance.nama,
      'nama_depan': instance.namadepan,
      'nama_belakang': instance.namabelakang,
      'gender': instance.gender,
      'tgl_lahir': instance.tgllahir,
      'email': instance.email,
      'telepon': instance.telepon,
      'alamat': instance.alamat,
      'admingrup': instance.admingrup,
    };
