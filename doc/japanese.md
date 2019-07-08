# スケジュールコントローラ

毎日複数の様々なタスクを実行する。とてもシンプルで便利なタイマー。 使いやすいです。定時にタスク実行する。毎回起動する前に予定なタスクを確認、タスクあるならば、タイミングタスク生成

<p align="left">
  <a href="https://pub.dartlang.org/packages/schedule_controller"><img alt="pub version" src="https://img.shields.io/pub/v/schedule_controller.svg"></a>
  <img alt="license" src="https://img.shields.io/github/license/TenkaiRuri/schedule_controller.svg">
</p>

## 使用方法
皆さんに説明しましょう

`callback`つまり、毎回実行される関数です

`timeOutRunOnce`はタイムアウト後に一度実行

`timing`毎日`timing`の時間に`callback`関数を呼び出すことを意味します。しかし、[午前8時30分]を[8.5]に置き換える必要があります。タイムゾーンに問題はありません、自動的にユーザーの時間に調整されます

`readFn`はデータを読み込むの関数、戻り値が必要です

`writeFn`はデータを書き込みの関数

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

## 言葉
[日本語](https://github.com/TenkaiRuri/schedule_controller/blob/master/doc/japanese.md#%E3%82%B9%E3%82%B1%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9) [简体中文](https://github.com/TenkaiRuri/schedule_controller/blob/master/doc/chinese.md#schedule-controller) [English](https://github.com/TenkaiRuri/schedule_controller#schedule_controller)