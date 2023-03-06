import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get formattedTime {
    return DateFormat('HH:mm').format(this);
  }

  String get formattedDateTime {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }
}
