import 'dart:developer';

import 'package:calendar_timeline/src/day_item.dart';
import 'package:calendar_timeline/src/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekDays extends StatelessWidget {
  final DateTime? initialDate;
  final List<DateTime> listOfMondays;
  final String locale;
  final SelectableDayPredicate? selectableDayPredicate;
  final void Function(DateTime selectedDay) onDaySelected;
  final Color? dayColor;
  final Color? activeDayColor;
  final Color? activeBackgroundDayColor;
  final Color? dotsColor;
  final Color? dayNameColor;
  final double leftMargin;

  const WeekDays(
      {Key? key,
      this.initialDate,
      required this.listOfMondays,
      required this.locale,
      this.selectableDayPredicate,
      this.dayColor,
      this.activeDayColor,
      this.activeBackgroundDayColor,
      this.dotsColor,
      this.dayNameColor,
      required this.leftMargin,
      required this.onDaySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(initialDate.toString());
    return SizedBox(
        height: 75,
        child: PageView.builder(
          controller: PageController(initialPage: 1),
          scrollDirection: Axis.horizontal,
          itemCount: listOfMondays.length ~/ 7,
          itemBuilder: (BuildContext context, int index) {
            final currentMonday = listOfMondays[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildWeek(currentMonday, index),
            );
          },
        ));
  }

  List<Widget> buildWeek(
    DateTime firstDayOfWeek,
    index,
  ) {
    final week = getWeekDays(listOfMondays[index]);
    return week.map((day) {
      final shortName = DateFormat.E(locale).format(day).capitalize();
      return DayItem(
        isSelected: initialDate?.isSameDay(day) ?? false,
        dayNumber: day.day,
        shortName: shortName.length > 3 ? shortName.substring(0, 3) : shortName,
        onTap: () => onDaySelected(day),
        available: selectableDayPredicate == null
            ? true
            : selectableDayPredicate!(day),
        dayColor: dayColor,
        activeDayColor: activeDayColor,
        activeDayBackgroundColor: activeBackgroundDayColor,
        dotsColor: dotsColor,
        dayNameColor: dayNameColor,
        isToday: DateTime.now().isSameDay(day),
      );
    }).toList();
  }
}
