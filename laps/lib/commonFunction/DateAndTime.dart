
import 'package:intl/intl.dart';

class DateUtil {
  static const DATE_FORMAT = 'dd/MM/yyyy';
  static const TIME_FORMAT = 'HH:mm';
  String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATE_FORMAT).format(dateTime);
  }

  String formattedDateandTime(DateTime dateTime) {
    print('dateTime ($dateTime)');
    String date = DateFormat(DATE_FORMAT).format(dateTime);
    String time = DateFormat(TIME_FORMAT).format(dateTime);
    String concat = "$date $time";
    return concat;
  }

}