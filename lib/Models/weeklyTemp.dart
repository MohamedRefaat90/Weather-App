import 'package:intl/intl.dart';

// Model For Contain DayName & maxTemp

class DailyTmp {
  String day;
  int? tmp;
  DailyTmp({
    required this.day,
    required this.tmp,
  });
}

/// Function to Retrun Object contain DayName & maxTemp to Build Chart ///

List<DailyTmp> getDaysTmp(week, Tmps) {
  // Convert String that Came from Api to DateTime then fromted to Represent DayName and Store in List
  List days =
      week.map((e) => DateFormat('EEEE').format(DateTime.parse(e))).toList();

  // List for Store Objects <WeeklyTmp> that Contain DayName & maxTemp
  List<DailyTmp> daysTmp = [];

  // Store objects ==> ex ==>  WeeklyTmp(Day: Friday, Tmp: 32) in List
  for (int i = 0; i < days.length; i++) {
    daysTmp.add(DailyTmp(day: days[i], tmp: Tmps[i].round()));
  }
  return daysTmp;
}
