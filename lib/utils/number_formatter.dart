import 'package:intl/intl.dart';

class NumberFormatter {
  static final _formatter = NumberFormat('#,###원');

  static String format(int number) {
    return _formatter.format(number).toString();
  }
}