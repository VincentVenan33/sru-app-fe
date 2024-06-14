import 'package:intl/intl.dart';

class CustomDateUtils {
  static final systemDefaultSourceDateFormat = DateFormat('yyyy-MM-dd');
  static final systemDefaultTargetDateFormat = DateFormat('dd MMM yyyy');

  static String convertToHumanDate(
    String date, {
    DateFormat? sourceFormat,
    DateFormat? desiredFormat,
  }) {
    final dateTime =
        (sourceFormat ?? systemDefaultSourceDateFormat).parse(date);
    final finalDesiredFormat = desiredFormat ?? systemDefaultTargetDateFormat;
    return finalDesiredFormat.format(dateTime);
  }
}
