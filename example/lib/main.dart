import 'package:flutter/material.dart';
import 'package:schedule_controller/schedule_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScheduleController controller;

  Future get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('test schedule')),
      ),
    );
  }
}
