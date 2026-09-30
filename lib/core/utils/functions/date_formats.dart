import 'package:intl/intl.dart';

String getMonthName(DateTime date) {
  return DateFormat.MMMM().format(date); // "August"
}

String getShortMonthName(DateTime date) {
  return DateFormat.MMM().format(date); // "Aug"
}

String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return 'Not set';

  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');

  return '${weekdays[dateTime.weekday - 1]}, ${months[dateTime.month - 1]} '
      '${dateTime.day}, $hour:$minute';
}
