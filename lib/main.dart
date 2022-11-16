import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intl Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateFormat _dateFormat;
  late DateFormat _timeFormat;
  late Timer _timer;
  late bool _isTimerStarted;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _setLocale('ru');
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _dateFormat.format(dateTime),
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              _timeFormat.format(dateTime),
              style: const TextStyle(fontSize: 36),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controlTimer,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _setLocale(String locale) {
    _dateFormat = DateFormat.yMMMMd(locale);
    _timeFormat = DateFormat.Hms(locale);
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        _isTimerStarted = true;
        setState(() {});
      },
    );
  }

  void _stopTimer() {
    _timer.cancel(); //stop the timer
    _isTimerStarted = false;
  }

  void _controlTimer() {
    if(_isTimerStarted) {
      _stopTimer();
    }
    else {
      _startTimer();
    }
  }
}