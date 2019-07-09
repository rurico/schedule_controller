part of schedule_controller;

/// What time from now until today how much [time]
/// [hour] is What time is today?
class TimestampHour {
  final int time;
  final double hour;
  const TimestampHour({this.time, this.hour});
}

/// morethen zero and lessthen zero list
class SplitTime {
  final List<TimestampHour> lessTime;
  final List<TimestampHour> moreTime;
  const SplitTime({this.lessTime, this.moreTime});
}

/// schedule task data
class ScheduleData {
  int daystart;
  bool notified;
  bool timeoutRunOnce;
  List<double> timing;
  List<double> remaining;

  ScheduleData({
    this.daystart,
    this.notified,
    this.timing,
    this.remaining,
    this.timeoutRunOnce = false,
  });

  ScheduleData.fromJson(Map<String, dynamic> json) {
    daystart = json['daystart'];
    notified = json['notified'];
    timeoutRunOnce = json['timeoutRunOnce'];
    timing =
        json['timing'] != null ? json['timing'].cast<double>() : <double>[];
    remaining = json['remaining'] != null
        ? json['remaining'].cast<double>()
        : <double>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['daystart'] = this.daystart;
    data['notified'] = this.notified;
    data['timeoutRunOnce'] = this.timeoutRunOnce;
    data['timing'] = this.timing;
    data['remaining'] = this.remaining;
    return data;
  }
}
