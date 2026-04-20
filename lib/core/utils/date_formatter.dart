import 'package:intl/intl.dart';

class DateFormatter {
  const DateFormatter._();

  static String fullDate(DateTime date) {
    return DateFormat('EEEE, dd MMM yyyy').format(date);
  }

  static String monthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static String homeHeading(DateTime selected, DateTime now) {
    final sd = DateTime(selected.year, selected.month, selected.day);
    final nd = DateTime(now.year, now.month, now.day);
    final dayPart = DateFormat('d MMM yyyy').format(selected);
    if (sd == nd) return 'Today, $dayPart';
    return '${DateFormat('EEE').format(selected)}, $dayPart';
  }

  static String monthDayLong(DateTime date) {
    return DateFormat('MMMM d').format(date);
  }
}
