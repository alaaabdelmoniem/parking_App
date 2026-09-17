import 'package:intl/intl.dart';

String getMonthName(DateTime date) {
  return DateFormat.MMMM().format(date); // "August"
}

String getShortMonthName(DateTime date) {
  return DateFormat.MMM().format(date); // "Aug"
}