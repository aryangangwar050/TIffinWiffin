import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/globals/global_data.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/custom_snackbar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

showCustomBottomsheet(int index, BuildContext context, Animation controller,
    {bool isPlan = false, bool isCalender = false, bool isMeal = false}) {
  var weekdays = GlobalData.weekdays;
  var offDays = GlobalData.offDays;
  var meals = GlobalData.meals;
  Size size = MediaQuery.of(context).size;

  showBottomSheet(
    context: context,
    elevation: 10,
    backgroundColor: Colors.black.withOpacity(0.2),
    transitionAnimationController: controller,
    builder: (context) {
      return Flex(
        direction: Axis.vertical,
        children: [
          Expanded(flex: 4, child: Container()),
          Expanded(
            flex: isCalender
                ? 5
                : isPlan
                    ? size.width > 360 && size.height > 700
                        ? 4
                        : 5
                    : 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(38),
                    topRight: Radius.circular(38),
                  )),
              child: isPlan
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(
                          color: Theme.of(context).primaryColor,
                          indent: MediaQuery.of(context).size.width / 2.1,
                          height: 30,
                          endIndent: MediaQuery.of(context).size.width / 2.2,
                          thickness: 3,
                        ),
                        Text(
                          "Choose Your Work Week",
                          textAlign: TextAlign.center,
                          style: cerebriMedium.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: GridView.builder(
                                itemCount: weekdays.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 20,
                                  childAspectRatio:
                                      size.width > 360 && size.height > 700
                                          ? 2.5
                                          : 2.5,
                                ),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (weekdays[index].off) {
                                        setState(() {
                                          weekdays[index].off = false;
                                        });
                                      } else {
                                        setState(() {
                                          weekdays[index].off = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 0.8,
                                            )
                                          ],
                                          color: !weekdays[index].off
                                              ? Theme.of(context).primaryColor
                                              : Colors.white),
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          top: 8,
                                          bottom: 8),
                                      child: Center(
                                        child: Text(
                                          weekdays[index].dayname,
                                          style: cerebriRegular.copyWith(
                                              fontSize: 14,
                                              color: !weekdays[index].off
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                      .primaryColor),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: size.width > 360 && size.height > 700
                              ? size.height * 0.08
                              : size.height * 0.05,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showCustomSnackBar(
                                  "Working On Order Placing will be avilable soon....",
                                  context,
                                  isError: false,
                                  isLong: true);
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 47),
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Theme.of(context).primaryColor),
                              child: Center(
                                  child: Text(
                                "Continue",
                                style: cerebriMedium.copyWith(
                                    fontSize: 16, color: Colors.white),
                              )),
                            ))
                      ],
                    )
                  : isCalender
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(
                              color: Theme.of(context).primaryColor,
                              indent: MediaQuery.of(context).size.width / 2.1,
                              height: 30,
                              endIndent:
                                  MediaQuery.of(context).size.width / 2.2,
                              thickness: 3,
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return SfDateRangePicker(
                                  allowViewNavigation: true,
                                  showNavigationArrow: true,
                                  headerHeight: 60,
                                  enablePastDates: false,
                                  onViewChanged:
                                      (dateRangePickerViewChangedArgs) {
                                    var now = dateRangePickerViewChangedArgs
                                        .visibleDateRange.startDate;

                                    var yearMonth =
                                        DateTime(now.year, now.month);

                                    var totalDays = daysInMonth(yearMonth);
                                    var listOfDates = new List<String>.generate(
                                        totalDays,
                                        (i) =>
                                            "${now.year}-${now.month < 10 ? '0${now.month}' : now.month}-${i + 1 < 10 ? '0${i + 1}' : i + 1}");

                                    var check = weekdays
                                        .where((element) => element.off)
                                        .toList();
                                    listOfDates.forEach((element) {
                                      var con = DateTime.parse(element);
                                      var weekdaynum = con.weekday;
                                      var weekday =
                                          weekdays[weekdaynum - 1].dayname;

                                      check.forEach((ofweek) {
                                        if (ofweek.dayname == weekday) {
                                          var checked = con;
                                          offDays.add(checked);
                                        }
                                      });
                                    });
                                  },
                                  onSelectionChanged:
                                      (dateRangePickerSelectionChangedArgs) {
                                    print(offDays);
                                  },
                                  monthViewSettings:
                                      DateRangePickerMonthViewSettings(
                                    blackoutDates: offDays,
                                  ),
                                  monthCellStyle: DateRangePickerMonthCellStyle(
                                      blackoutDatesDecoration: BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.circle),
                                      blackoutDateTextStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  headerStyle: DateRangePickerHeaderStyle(
                                    textAlign: TextAlign.center,
                                    textStyle: cerebriMedium.copyWith(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  initialSelectedDate: DateTime.now(),
                                  view: DateRangePickerView.month,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                );
                              },
                            )
                          ],
                        )
                      : isMeal
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Divider(
                                  color: Theme.of(context).primaryColor,
                                  indent:
                                      MediaQuery.of(context).size.width / 2.1,
                                  height: 30,
                                  endIndent:
                                      MediaQuery.of(context).size.width / 2.2,
                                  thickness: 3,
                                ),
                                Text(
                                  "Choose Your Meal",
                                  textAlign: TextAlign.center,
                                  style: cerebriMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return CustomRadioButton(
                                        buttonTextStyle: ButtonTextStyle(
                                          selectedColor: Colors.white,
                                          unSelectedColor:
                                              Theme.of(context).primaryColor,
                                          textStyle: cerebriMedium.copyWith(
                                              fontSize: 16),
                                        ),
                                        autoWidth: false,
                                        enableButtonWrap: true,
                                        wrapAlignment: WrapAlignment.center,
                                        unSelectedColor:
                                            Theme.of(context).canvasColor,
                                        buttonLables: [
                                          meals[0].meals,
                                          meals[1].meals,
                                        ],
                                        buttonValues: [
                                          meals[0].meals,
                                          meals[1].meals,
                                        ],
                                        defaultSelected: meals[0].meals,
                                        horizontal: false,
                                        width: 150,
                                        height: 40,
                                        elevation: 2,
                                        selectedBorderColor:
                                            Theme.of(context).primaryColor,
                                        unSelectedBorderColor: Colors.white,
                                        selectedColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        padding: 15,
                                        enableShape: true,
                                        radioButtonValue: (Object) {
                                          print(Object);
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            )
                          : SizedBox.shrink(),
            ),
          ),
        ],
      );
    },
  ).closed.whenComplete(() {
    print("bottomsheet closed");
  });
}

class Week {
  final String dayname;
  bool off;

  Week({@required this.dayname, @required this.off});
}

class Meals {
  final String meals;
  bool isselected;

  Meals({@required this.meals, @required this.isselected});
}

int daysInMonth(DateTime date) {
  var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
      firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}
