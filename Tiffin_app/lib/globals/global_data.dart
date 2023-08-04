import 'package:flutter_grocery/view/base/custom_bottomsheet.dart';

class GlobalData {
  static List<Week> weekdays = [
    Week(dayname: "Monday", off: false),
    Week(dayname: "Tuesday", off: false),
    Week(dayname: "Wednesday", off: false),
    Week(dayname: "Thursday", off: false),
    Week(dayname: "Friday", off: false),
    Week(dayname: "Saturday", off: true),
    Week(dayname: "Sunday", off: true),
  ];

  static List<Meals> meals = [
    Meals(meals: "Half", isselected: false),
    Meals(meals: "Full", isselected: true),
  ];

  static List<DateTime> offDays = [];
}
