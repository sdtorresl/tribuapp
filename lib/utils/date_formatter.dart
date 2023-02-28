import 'package:intl/intl.dart';

class DateFormatter {
  static dateTimeToString(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd').add_jm();
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}
