import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String humanReadableDate() => DateFormat('dd/MM/yyyy – kk:mm').format(this);
  String humanReadableDateOnlyHours() => DateFormat('kk:mm').format(this);
}
