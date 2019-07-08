# schedule controller

每天执行几项不同的任务。非常简单实用的计时器。它易于使用。在固定时间执行任务。每次启动前确认计划任务，如果有任务，计时任务生成。

<p align="left">
  <a href="https://pub.dartlang.org/packages/schedule_controller"><img alt="pub version" src="https://img.shields.io/pub/v/schedule_controller.svg"></a>
  <img alt="license" src="https://img.shields.io/github/license/TenkaiRuri/schedule_controller.svg">
</p>

## 用户指南
我来给大家解释一下

`callback`就是说你需要每次启动都定时执行的函数

`timeOutRunOnce`的意思是超时了也会执行一次

`timing`的意思是每天什么时候会调用`callback`函数，但是，你需要将[早上八点半]替换为[8.5]，按照`timing`输入的时间定时执行，没有时区的问题，会自动调整到使用者的时间。

`readFn`就是读取数据的函数，必须要有返回值

`writeFn`就是写入数据的函数

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

## 语言
[简体中文](https://github.com/TenkaiRuri/schedule_controller/blob/master/doc/chinese.md#schedule-controller) [English](https://github.com/TenkaiRuri/schedule_controller#schedule_controller) [日本語](https://github.com/TenkaiRuri/schedule_controller/blob/master/doc/japanese.md#%E3%82%B9%E3%82%B1%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9)