import 'package:flutter/material.dart';
import 'package:sru/core/app_constants/colors.dart';

int _roundToNearest100(int value) {
  return (value / 100).round() * 100;
}

Map<int, FontWeight> _weightToObject = {
  300: FontWeight.w300,
  400: FontWeight.w400,
  500: FontWeight.w500,
  600: FontWeight.w600,
  700: FontWeight.w700,
};

Map<double, List<int>> _sizeToWeight = <double, List<int>>{
  10.5: <int>[600],
  12: <int>[400, 600],
  14: <int>[400, 600],
  16: <int>[400, 600, 700],
  18: <int>[700],
  20: <int>[700],
  22: <int>[700],
  28: <int>[700],
  32: <int>[700],
};

FontWeight normalizeFontWeight(double size, int weight) {
  List<int>? allowedFontWeights = _sizeToWeight[size];

  if (allowedFontWeights == null || weight < 400) return FontWeight.normal;

  int roundedWeight = _roundToNearest100(weight);

  if (!allowedFontWeights.contains(roundedWeight)) {
    return _weightToObject[allowedFontWeights[0]]!;
  }

  return _weightToObject[roundedWeight]!;
}

TextStyle buildTextStyle({
  num fontSize = 14,
  int fontWeight = 400,
  Color color = sruColor.black002,
  TextDecoration? decoration,
  double? fontHeight,
  double? letterSpacing,
}) {
  double fontSizeInDouble = fontSize.toDouble();

  return TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: fontSizeInDouble,
    // fontWeight: normalizeFontWeight(
    //   fontSizeInDouble,
    //   fontWeight,
    // ),
    fontWeight: _weightToObject[fontWeight],
    color: color,
    height: fontHeight == null ? 1.2 : fontHeight / fontSizeInDouble,
    letterSpacing: letterSpacing,
    decoration: decoration,
  );
}
