// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format_hhmm_ddMMyyyy() {
    return DateFormat('HH:mm dd.MM.yyyy').format(toLocalTime);
  }

  String format_yyyyMMdd_HHmmss() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(toLocalTime);
  }

  DateTime get toLocalTime => DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch,
        isUtc: true,
      ).toLocal();

  String get onlyDate => DateFormat('dd/MM/yyyy').format(toLocalTime);

  String get onlyTime => DateFormat('HH:mm').format(toLocalTime);

  String get onlyTimeWithSeconds => DateFormat('HH:mm:ss').format(toLocalTime);

  String get onlyTimeOrDateAndTime {
    final now = DateTime.now();
    if (now.day == day && now.month == month && now.year == year) {
      return onlyTime;
    }

    return format_hhmm_ddMMyyyy();
  }

  String toMMMd() {
    return DateFormat.MMMd().format(toLocalTime);
  }

  String toMMMdy() {
    final dateFormat = DateFormat('MMM d, y');

    return dateFormat.format(toLocalTime);
  }

  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}
