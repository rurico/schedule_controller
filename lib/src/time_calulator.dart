part of schedule_controller;

/// Convenient access to some timestamps
class TimeCalculator {
  /// one day timestamp
  int get oneDay => hoursMs(24);

  /// current timestamp
  int get timestamp => DateTime.now().millisecondsSinceEpoch;

  /// today day start timestamp
  int get todayStart => dayStart(timestamp);

  /// today day end timestamp
  int get todayEnd => todayStart + oneDay;

  /// return microseconds according to [hour]
  int hoursMs(double hour) => (hour * 3600000).floor();

  /// get [dayStart] of the day according to [time]
  int dayStart(int time) {
    final dayStartTimestamp = convertTimeStampToDays(time) * oneDay;
    final timeZoneOffset = DateTime.now().timeZoneOffset.inMilliseconds;
    return dayStartTimestamp - timeZoneOffset;
  }

  /// convert timestamp to days
  int convertTimeStampToDays(int time) {
    return (time / oneDay).floor();
  }

  /// get [dayEnd] of the day according to [time]
  int dayEnd(int time) => dayStart(time) + oneDay;

  /// The difference between the current [time] and the start time of today's day
  int dayStartTimeDiff(int time) => timestamp - dayStart(time);

  /// The difference between the current [time] and the end time of today's day
  int dayEndTimeDiff(int time) => timestamp - dayEnd(time);

  /// What time from now until today how much [hour]
  int elapsedTimeOfToday(double hour) => todayStart + hoursMs(hour) - timestamp;

  /// is a new day
  bool isNewDay(int oldTime) => timestamp - dayStart(oldTime) < 0;
}
