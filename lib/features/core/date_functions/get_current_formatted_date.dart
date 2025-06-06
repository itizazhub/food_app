import 'package:intl/intl.dart';

String getCurrentFormattedDate() {
  final now = DateTime.now();
  final formatter = DateFormat('dd/MM/yy');
  return formatter.format(now);
}
