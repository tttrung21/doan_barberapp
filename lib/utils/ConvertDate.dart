import 'package:intl/intl.dart';

class ConvertDate {
  static DateTime dateTimeNow = DateTime.now();
  static DateTime defaults = DateTime(2019, 1, 1);
  static DateTime today = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
  // lấy ra tuần của ngày hiện tại.
  static final week = today.weekday;
  static DateTime dateSelect = today;

  // lấy ra ngày đầu tiên của tuần.
  static DateTime dayS = today.subtract(Duration(days: week - 1));

  static List<DateTime> days = [];

  static List<DateTime> weekStartEnd(int weekSelect) {
    final i = weekSelect - week;
    final daySelectS = dayS.add(Duration(days: i * 7));
    days = [daySelectS];
    for (var n = 1; n < 7; n++) {
      days.add(daySelectS.add(Duration(days: n)));
    }
    return days.toList();
  }

  static String decimaltoString(double? totalSeconds, String format) {
    return totalSeconds != null ? DateFormat(format).format(defaults.add(Duration(seconds: totalSeconds.round()))) : '';
  }

  // lấy ra ngày cuối của tuần.
  static DateTime dayWeekEnd = dayS.add(Duration(days: 6));

  static DateTime dayStartMonth = DateTime(dateTimeNow.year, dateTimeNow.month, 1);

  static DateTime dayEndMonth = DateTime(dateTimeNow.year, dateTimeNow.month + 1, 0);

  static DateTime dayStartMonthBefor = DateTime(dateTimeNow.year, dateTimeNow.month - 1);
  static DateTime dayEndMonthBefor = DateTime(dateTimeNow.year, dateTimeNow.month).add(Duration(seconds: -1));

  static int CountWeekinMonth() {
    final date = DateTime.now();
    final totalday = DayInmonth(date.month, date.year);
    final firstOfMonth = DateTime(date.year, date.month, 1);
    final firstDayOfMonth = DayOfWeek(firstOfMonth.weekday);
    final weeksInMonth = ((firstDayOfMonth + totalday) / 7.0).ceil();
    return weeksInMonth;
  }

  static int DayInmonth(int month, int year) {
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
      return 31;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    } else {
      if (year % 4 == 0) {
        return 29;
      } else {
        return 28;
      }
    }
  }

  static int DayOfWeek(int day) {
    return day - 1;
  }
}
