part of schedule_controller;

/// TODO Skip holidays and weekend

/// A Schedule controller
class ScheduleController {
  final List<Schedule> tasks;
  const ScheduleController(this.tasks);

  /// run the schedule tasks
  run() {
    tasks.forEach((task) async {
      final data = await task._readFile(task.readFn);

      final state = data == null ? task._getInstance() : data;

      task._runTask(state, task.writeFn);
    });
  }
}

/// A schedule class
class Schedule {
  final List<double> timing;
  final bool timeOutRunOnce;
  final VoidCallback callback;
  final StringCallback readFn;
  final CallbackString writeFn;

  final _timerCalculator = TimeCalculator();

  Schedule({
    this.timing,
    this.callback,
    this.readFn,
    this.writeFn,
    this.timeOutRunOnce = false,
  });

  ScheduleData _getInstance() {
    return ScheduleData(
      daystart: _timerCalculator.todayStart,
      timing: timing,
      remaining: timing,
      timeoutRunOnce: timeOutRunOnce,
      notified: false,
    );
  }

  ScheduleData _runTask(ScheduleData oldState, CallbackString writeFn) {
    final splitTime = _getSplitTime(oldState.timing);

    final newState = _updateInstance(
      oldState,
      splitTime.moreTime.map((data) => data.hour).toList(),
      oldState.notified,
    );

    if (newState.timeoutRunOnce &&
        splitTime.lessTime.length > 0 &&
        !oldState.notified) callback();

    splitTime.moreTime.forEach((data) {
      Future.delayed(Duration(milliseconds: data.time), callback);
    });

    _writeFile(newState, writeFn);

    return newState;
  }

  ScheduleData _updateInstance(
    ScheduleData state,
    List<double> moreTime,
    bool notified,
  ) {
    final isNewDay = _timerCalculator.isNewDay(state.daystart);

    return ScheduleData(
      daystart: _timerCalculator.todayStart,
      timing: state.timing,
      remaining: isNewDay ? state.timing : moreTime,
      timeoutRunOnce: state.timeoutRunOnce,
      notified: !(isNewDay && notified),
    );
  }

  SplitTime _splitByZero(Iterable<TimestampHour> list) {
    final less = <TimestampHour>[], more = <TimestampHour>[];
    for (final item in list) item.time > 0 ? more.add(item) : less.add(item);
    return SplitTime(lessTime: less, moreTime: more);
  }

  SplitTime _getSplitTime(List<double> remaining) {
    final elapsedList = remaining.map((hour) {
      return TimestampHour(
        hour: hour,
        time: _timerCalculator.elapsedTimeOfToday(hour),
      );
    });
    final splitTime = _splitByZero(elapsedList);
    return splitTime;
  }

  Future<ScheduleData> _readFile(StringCallback readFn) async {
    final String dataStr = await readFn();
    if (dataStr == null) return null;
    final Map<String, dynamic> dataMap = json.decode(dataStr);
    return ScheduleData.fromJson(dataMap);
  }

  _writeFile(ScheduleData data, CallbackString writeFn) async {
    final timerMap = data.toJson();
    final timerJson = json.encode(timerMap);
    await writeFn(timerJson);
  }
}
