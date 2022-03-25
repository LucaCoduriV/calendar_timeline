export 'string_extension.dart';

extension DateCalc on DateTime {
  /// Retourne le lundi de la semaine
  DateTime firstDayOfWeek() {
    return findFirstDateOfTheWeek(this);
  }

  /// Retourne le dimanche de la semaine
  DateTime lastDayOfWeek() {
    return findLastDateOfTheWeek(this);
  }

  /// Returns all days of the current week.
  List<DateTime> weekDays() {
    return getWeekDays(this);
  }

  /// Returns all Monday Between two dates.
  static List<DateTime> getWeekFirstDayInRange(DateTime start, DateTime end) {
    return getFirstDayOfWeeksBetween(start, end);
  }
}

/// Find the first date of the week which contains the provided date.
DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

/// Find last date of the week which contains provided date.
DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
}

/// get week days as DateTime
List<DateTime> getWeekDays(DateTime dateTime) {
  final firstDayOfWeek = findFirstDateOfTheWeek(dateTime);
  return List.generate(DateTime.daysPerWeek, (index) {
    return firstDayOfWeek.add(Duration(days: index));
  });
}

List<DateTime> getFirstDayOfWeeksBetween(DateTime start, DateTime end) {
  final firstDayOfWeek = findFirstDateOfTheWeek(start);
  final lastDayOfWeek = findLastDateOfTheWeek(end);
  final weeks = lastDayOfWeek.difference(firstDayOfWeek).inDays ~/ 7;
  return List.generate(weeks, (index) {
    return firstDayOfWeek.add(Duration(days: index * 7));
  });
}
