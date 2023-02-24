import 'package:intl/intl.dart';

extension TimestamptoD12 on int {
  String d12() {
    var date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(date);
    return d12;
  }
}
