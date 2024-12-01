class Time {
  static DateTime getWeekStart(DateTime date) {
    return DateTime(date.year, date.month, date.day - date.weekday % 7);
  }

  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }
}
