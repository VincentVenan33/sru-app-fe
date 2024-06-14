import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/models/authentication/login.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider<SharedPreferencesService>(
  (_) => SharedPreferencesService(),
);

enum SharedPrefKeys {
  tokenLogin,
  nomorUser,
  userData,
  detailItemOrderJual,
}

extension SharedPrefKeysExt on SharedPrefKeys {
  static const Map<SharedPrefKeys, String> _labels = <SharedPrefKeys, String>{
    SharedPrefKeys.tokenLogin: 'token_login',
    SharedPrefKeys.nomorUser: 'nomor_user',
    SharedPrefKeys.userData: 'user_data',
    SharedPrefKeys.detailItemOrderJual: 'detailItemOrderJual',
  };

  String get label => _labels[this] ?? '';
}

class SharedPreferencesService {
  late SharedPreferences _sharedPreferences;
  bool _ready = false;

  Future<void> _getSharedPreferences() async {
    if (!_ready) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _ready = true;
    }
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<dynamic> get(SharedPrefKeys key) async {
    await _getSharedPreferences();
    switch (key) {
      case SharedPrefKeys.tokenLogin:
        if (_sharedPreferences.getString(SharedPrefKeys.tokenLogin.label).toString() == 'null' ||
            _sharedPreferences.getString(SharedPrefKeys.tokenLogin.label) == null) {
          return null;
        }
        if ((_sharedPreferences.getString(SharedPrefKeys.tokenLogin.label) ?? '').isNotEmpty) {
          final Map<String, dynamic> response = json.decode(
            _sharedPreferences.getString(key.label) ?? '',
          );
          return LoginResponseData.fromJson(response);
        }
        return null;
      case SharedPrefKeys.userData:
        if (_sharedPreferences.getString(SharedPrefKeys.userData.label).toString() == 'null' ||
            _sharedPreferences.getString(SharedPrefKeys.userData.label) == null) {
          return null;
        }
        if ((_sharedPreferences.getString(SharedPrefKeys.userData.label) ?? '').isNotEmpty) {
          final Map<String, dynamic> response = json.decode(
            _sharedPreferences.getString(key.label) ?? '',
          );
          return UserData.fromJson(response);
        }
        return null;
      case SharedPrefKeys.nomorUser:
      // Handle this case.
      case SharedPrefKeys.detailItemOrderJual:
        final String? result = _sharedPreferences.getString(
          SharedPrefKeys.detailItemOrderJual.label,
        );
        if (result == null) {
          return null;
        }
        final Map<String, dynamic> response = json.decode(
          _sharedPreferences.getString(key.label) ?? '',
        );
        return ListDetailItem.fromJson(response);

      // break;
    }
  }

  Future<void> set(SharedPrefKeys key, dynamic value) async {
    await _getSharedPreferences();
    final String jsonString = json.encode(value);

    await _sharedPreferences.setString(key.label, jsonString);
  }

  Future<void> clearStorage() async {
    await _sharedPreferences.clear();
  }
}
