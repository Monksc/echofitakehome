import 'package:flutter/material.dart';

class LapViews extends StatelessWidget {
  final List<Duration> durations;
  LapViews({@required this.durations = const <Duration>[]});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: durations.length == 0 ? 0 : 2 * durations.length - 1,
        itemBuilder: (BuildContext context, int index) => index % 2 == 0
            ? _LapView(duration: durations[index ~/ 2])
            : Divider(),
      ),
    );
  }
}

class _LapView extends StatelessWidget {
  final Duration duration;
  _LapView({@required this.duration = const Duration()});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(formatTime()),
    );
  }

  String formatTime() {
    String space = "    ";
    return "${duration.inHours}h${space}${duration.inMinutes.remainder(60)}m${space}${(duration.inSeconds.remainder(60))}s${space}${(duration.inMilliseconds.remainder(1000))}ms";
  }
}
