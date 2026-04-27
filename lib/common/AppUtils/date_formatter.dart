import 'package:intl/intl.dart';

String dateFormat(DateTime date) {
  return DateFormat.yMMMEd().format(date);
}

String timeFormat(DateTime date) {
  return DateFormat.jms().format(date);
}
