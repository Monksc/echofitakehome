import 'package:flutter/material.dart';
import 'views/custombuttons.dart';
import 'views/drawcircleview.dart';
import 'views/laptimesview.dart';
import 'dart:math' as math;
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final int TIME_TO_UPDATE = 10;
  Stopwatch watch = new Stopwatch();
  Timer? timer;

  Duration totalInLaps = Duration(seconds: 0);
  List<Duration> lapTimes = [];

  Widget bottomButton(String text, VoidCallback? onPressed) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SecondaryButton(
          text: text,
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2d3f52),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: Stack(
                children: <Widget>[
                  CircleView(
                      color: Colors.yellow,
                      angle:
                          ((watch.elapsedMicroseconds % 60000000) / 60000000) *
                              2 *
                              math.pi),
                  Center(
                    child: Text(
                      formatTime(),
                      style: const TextStyle(
                        fontSize: 75.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        decorationStyle: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(height: 100.0),
            child: LapViews(
              durations: lapTimes,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 100.0,
              maxHeight: 100.0,
              maxWidth: 800,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  bottomButton('Reset', _resetButtonPressed),
                  bottomButton(timer == null ? 'Start' : 'Stop',
                      _startStopButtonPressed),
                  bottomButton('Lap', _lapButtonPressed),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: Buttons Clicked

  void _resetButtonPressed() {
    setState(() {
      watch.reset();
      totalInLaps = Duration(seconds: 0);
      lapTimes = [];
    });
  }

  void _startStopButtonPressed() {
    if (timer == null) {
      setState(() {
        timer =
            Timer.periodic(Duration(milliseconds: TIME_TO_UPDATE), _updateTime);
        watch.start();
      });
    } else {
      setState(() {
        timer!.cancel();
        watch.stop();
        timer = null;
      });
    }
  }

  void _lapButtonPressed() {
    Duration elapsed = watch.elapsed;
    Duration duration = elapsed - totalInLaps;
    totalInLaps = elapsed;

    setState(() {
      lapTimes.add(duration);
    });
  }

  // MARK: Private functions

  void _updateTime(Timer timer) {
    setState(() {});
  }

  String formatTime() {
    Duration duration = watch.elapsed;
    return "${duration.inHours}:${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}:${(duration.inMilliseconds.remainder(1000)) ~/ 10}";
  }
}
