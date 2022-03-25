import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:calendar_timeline/src/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'day_item.dart';

class WeekDays extends StatelessWidget {
  final int? daySelectedIndex;
  final List<DateTime> days;
  final String locale;
  final SelectableDayPredicate? selectableDayPredicate;
  final void Function(int index) goToDay;
  final Color? dayColor;
  final Color? activeDayColor;
  final Color? activeBackgroundDayColor;
  final Color? dotsColor;
  final Color? dayNameColor;
  final double leftMargin;

  const WeekDays(
      {Key? key,
      this.daySelectedIndex,
      required this.days,
      required this.locale,
      this.selectableDayPredicate,
      this.dayColor,
      this.activeDayColor,
      this.activeBackgroundDayColor,
      this.dotsColor,
      this.dayNameColor,
      required this.leftMargin,
      required this.goToDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 75,
        child: PageView.builder(
          controller: PageController(initialPage: 1),
          scrollDirection: Axis.horizontal,
          itemCount: days.length ~/ 7,
          itemBuilder: (BuildContext context, int index) {
            final currentDay = days[index];
            final shortName =
                DateFormat.E(locale).format(currentDay).capitalize();
            return Row(
              children: [
                ...buildOneDay(currentDay, index, shortName),
                if (index == days.length - 1)
                  SizedBox(
                      width:
                          MediaQuery.of(context).size.width - leftMargin - 65)
              ],
            );
          },
        ));
  }

  List<Widget> buildOneDay(
    DateTime currentDay,
    index,
    shortName,
  ) {
    return getWeekDays(currentDay).map((e) {
      return DayItem(
        isSelected: daySelectedIndex == index,
        dayNumber: currentDay.day,
        shortName: shortName.length > 3 ? shortName.substring(0, 3) : shortName,
        onTap: () => goToDay(index),
        available: selectableDayPredicate == null
            ? true
            : selectableDayPredicate!(currentDay),
        dayColor: dayColor,
        activeDayColor: activeDayColor,
        activeDayBackgroundColor: activeBackgroundDayColor,
        dotsColor: dotsColor,
        dayNameColor: dayNameColor,
        isToday: DateTime.now().month == currentDay.month &&
            DateTime.now().day == currentDay.day &&
            DateTime.now().year == currentDay.year,
      );
    }).toList();
  }
}
