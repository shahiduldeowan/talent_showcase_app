import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  /// Format a date as "dd MMM, yyyy" (e.g. "18 Nov, 2025").
  ///
  /// If [date] is null, the current date is used.
  static String defaultDateFormat([DateTime? date]) {
    return DateFormat('dd MMM, yyyy').format(date ?? DateTime.now());
  }
}
