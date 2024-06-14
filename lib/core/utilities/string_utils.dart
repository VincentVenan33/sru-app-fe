import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringUtils {
  static List<String> get alphabets {
    int currentASCII = 65;
    final List<String> results = <String>[];
    for (int i = 0; i < 26; i++) {
      results.add(
        String.fromCharCode(currentASCII++),
      );
    }
    return results;
  }

  static bool isNullOrEmptyString(String? value) {
    if (value == null || value.isEmpty == true) return true;
    return false;
  }

  static String removeZeroWidthSpaces(String value) =>
      value.replaceAll('', '\u200B');

  static String rupiahFormat(
    double nominal, {
    String symbol = '',
  }) {
    var f = NumberFormat.currency(
      locale: 'id_ID',
      symbol: symbol,
      decimalDigits: 0,
    );

    return f.format(nominal);
  }
}

class Formatter {
  // need to clean this util code
  static String buildIndonesianCurrencyFormat(
    String value, [
    String prefix = 'Rp ',
  ]) {
    return NumberFormat.currency(locale: 'id', decimalDigits: 0)
        .format(double.parse(value))
        .replaceAll('IDR', prefix);
  }

  static String digitWithScale(
    String text,
    int scaleLen, {
    required int digitsAfterDecimal,
  }) {
    final int totalDigitAfterScale = text.length - scaleLen;
    final String digitAfterScale = text.substring(0, totalDigitAfterScale);
    final String digitBehindScale = text.substring(
      totalDigitAfterScale,
      totalDigitAfterScale + digitsAfterDecimal,
    );

    final bool showDecimalDigit =
        totalDigitAfterScale < 3 && int.parse(digitBehindScale) > 0;
    if (showDecimalDigit) {
      return '$digitAfterScale,$digitBehindScale';
    }
    return digitAfterScale;
  }

  static String simplifyNumber(
    num number, {
    int digitsAfterDecimal = 2,
  }) {
    final String text = number.toString();
    final String removeNonNumericCharacter = text.replaceAll(r'[^\\d]', '');
    final int stringLength = removeNonNumericCharacter.length;
    if (stringLength > 12) {
      return '${digitWithScale(
        removeNonNumericCharacter,
        12,
        digitsAfterDecimal: digitsAfterDecimal,
      )}T';
    }
    if (stringLength > 9) {
      return '${digitWithScale(
        removeNonNumericCharacter,
        9,
        digitsAfterDecimal: digitsAfterDecimal,
      )}B';
    }
    if (stringLength > 6) {
      return '${digitWithScale(
        removeNonNumericCharacter,
        6,
        digitsAfterDecimal: digitsAfterDecimal,
      )}M';
    }
    if (stringLength > 3) {
      return '${digitWithScale(
        removeNonNumericCharacter,
        3,
        digitsAfterDecimal: digitsAfterDecimal,
      )}K';
    }

    return text;
  }

  static String modifyAfterDecimal(
    String number, {
    int digitAfterDecimal = 2,
    bool removeTrailingZero = true,
  }) {
    double numberAsDouble = double.tryParse(number) ?? 0;
    final String newNumber = numberAsDouble.toStringAsFixed(digitAfterDecimal);
    if (removeTrailingZero) {
      String traillingZeroes = '';
      final String afterDecimal = newNumber.split('.').last;
      for (int i = 0; i < afterDecimal.length; i++) {
        traillingZeroes += '0';
      }
      numberAsDouble = double.tryParse(newNumber) ?? 0;
      if (afterDecimal == traillingZeroes) {
        return numberAsDouble.toStringAsFixed(0);
      }
    }
    return newNumber;
  }

  static String numberWithThousandSeparator(int number) {
    return NumberFormat('#,###').format(number).replaceAll(',', '.');
  }
}

extension StringX on String {
  String get overflowForSingleLine => Characters(this)
      .replaceAll(Characters(''), Characters('\u{200B}'))
      .toString();

  /// check if the string is a UUID (version 3, 4 or 5).
  bool isValidUUID() {
    // If its not 36 characters in length, don't bother (including dashes).
    if (length != 36) {
      return false;
    }

    const String pattern =
        r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[0-9a-f]{4}-[0-9a-f]{12}$';
    final RegExp regex = RegExp(pattern, caseSensitive: false, multiLine: true);
    final bool match = regex.hasMatch(this);
    return match;
  }
}
