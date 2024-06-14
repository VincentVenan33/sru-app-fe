import 'package:intl/intl.dart';

enum PeriodFilter {
  month,
  sixMonths,
  year,
  custom,
}

extension PeriodFilterExt on PeriodFilter {
  static const Map<PeriodFilter, String> aliases = <PeriodFilter, String>{
    PeriodFilter.month: 'month',
    PeriodFilter.sixMonths: 'sixMonths',
    PeriodFilter.year: 'year',
    PeriodFilter.custom: 'custom',
  };

  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String get startDate {
    switch (this) {
      case PeriodFilter.month:
        final DateTime now = DateTime.now();
        final String formattedDate = dateFormat.format(now);
        final List<String> splittedDate = formattedDate.split('-');
        splittedDate.removeLast();
        final String formattedDateWithoutDay = splittedDate.join('-');
        return '$formattedDateWithoutDay-01';
      case PeriodFilter.sixMonths:
        final DateTime now = DateTime.now();
        final DateTime lastSixMonth = DateTime(
          now.month - 6 > 0 ? now.year : now.year - 1,
          now.month - 6,
          now.day,
        );
        final String formattedDate = dateFormat.format(lastSixMonth);
        return formattedDate;
      case PeriodFilter.year:
        final DateTime now = DateTime.now();
        return '${now.year}-01-01';
      default:
        return '';
    }
  }

  String get endDate {
    switch (this) {
      case PeriodFilter.month:
        final DateTime now = DateTime.now();
        final DateTime lastDayOfMonth = now.month < 12
            ? DateTime(now.year, now.month + 1, 0)
            : DateTime(now.year + 1, 1, 0);
        final String formattedDate = dateFormat.format(lastDayOfMonth);
        return formattedDate;
      case PeriodFilter.sixMonths:
        final DateTime now = DateTime.now();
        return dateFormat.format(now);
      case PeriodFilter.year:
        final DateTime now = DateTime.now();
        return '${now.year}-12-31';
      default:
        return '';
    }
  }
}
