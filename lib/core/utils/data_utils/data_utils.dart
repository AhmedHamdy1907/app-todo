// import 'package:intl/intl.dart';
// String dataformate (DateTime data)
// {
// final DateFormat formatter=DateFormat("dd/MM/yyyy");
// return formatter.format(data);
//
// }
extension formater on DateTime
{
  String get formate=>"${day}/${month}/${year}"; // كده انا ضفت FUNCTION معينه بترجع ال  FORMATE علي هذخ الهيئة
  String get getDay
  {
 List<String>weekDays=["Mon","TUE","WED","THU","FRI","SAT","Sun"];
  weekday;// بيديني ال Index بتاع اليوم
return weekDays[weekday-1]; // كده انا رجعت اليوم الحصري
  }
}