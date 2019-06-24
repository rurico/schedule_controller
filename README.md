# schedule_controller

Perform several different tasks daily. Very simple and useful timer. It is easy to use. Execute task at fixed time. Confirm scheduled tasks before starting each time, if there are tasks, timing task generation.

<p align="left">
  <a href="https://pub.dartlang.org/packages/schedule_controller"><img alt="pub version" src="https://img.shields.io/pub/v/schedule_controller.svg"></a>
  <img alt="license" src="https://img.shields.io/github/license/TenkaiRuri/schedule_controller.svg">
</p>

## Usage
Let's explain to everyone

`callback` is a function that is executed every time

`timeOutRunOnce` is mean run once after timeout

`timing` means to call the` callback` function at every `timing` time. But you need to replace the [8:30AM] to [8.5]. There is no problem with the time zone, it will be automatically adjusted to the user's time.

`readFn` is a function to read data, you must return a value

`writeFn` is a function to write data

```dart
Future get(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}

Future save(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

controller = ScheduleController([
  Schedule(
    timeOutRunOnce: true,
    timing: [8, 10.5, 16, 18],
    readFn: () async => await get('schedule'),
    writeFn: (String data) async {
      debugPrint(data);
      await save('schedule', data);
    },
    callback: () {
      debugPrint('schedule');
    },
  ),
]);
controller.run();
```

## Languages
[English](https://github.com/TenkaiRuri/schedule_controller) [日本語](https://github.com/TenkaiRuri/schedule_controller/blob/master/doc/japanese.md) [简体中文](https://github.com/TenkaiRuri/schedule_controller/blob/master/doc/chinese.md)