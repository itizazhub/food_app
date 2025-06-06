import 'package:intl/intl.dart';

DateTime parseFormattedDate(String dateString) {
  final formatter = DateFormat('dd/MM/yy');
  return formatter.parse(dateString);
}
