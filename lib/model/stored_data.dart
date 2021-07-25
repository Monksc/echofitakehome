import 'package:shared_preferences/shared_preferences.dart';

const String LAPS_KEY = 'laps_key';

Future<List<Duration>> getLaps() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? timesAsStr = prefs.getStringList(LAPS_KEY);
  if (timesAsStr == null) {
    return [];
  }
  return List.from(timesAsStr.map((s) => Duration(microseconds: int.parse(s))));
}

Future<void> storeLaps(List<Duration> laps) async {
  List<String> lapsAsStr = List.from(laps.map((l) => "${l.inMicroseconds}"));

  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(LAPS_KEY, lapsAsStr);
}

const String TOTAL_TIME_IN_LAPS_KEY = 'total_time_laps_key';

Future<Duration> getTotalTimeInLaps() async {
  final prefs = await SharedPreferences.getInstance();
  int? time = prefs.getInt(TOTAL_TIME_IN_LAPS_KEY);
  if (time == null) {
    return Duration(microseconds: 0);
  }
  return Duration(microseconds: time);
}

Future<void> storeTotalTimeInLaps(Duration d) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(TOTAL_TIME_IN_LAPS_KEY, d.inMicroseconds);
}

const String TIME_APP_CLOSED_KEY = 'time_app_closed_key';

Future<Duration?> getTimeAppClosed() async {
  final prefs = await SharedPreferences.getInstance();
  int? time = prefs.getInt(TIME_APP_CLOSED_KEY);
  if (time == null) {
    return null;
  }

  if (time == 0) {
    return null;
  }

  Duration d =
      DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(time));
  return d;
}

Future<void> storeTimeAppClosed(DateTime? time) async {
  final prefs = await SharedPreferences.getInstance();
  if (time == null) {
    prefs.setInt(TIME_APP_CLOSED_KEY, 0);
  } else {
    prefs.setInt(TIME_APP_CLOSED_KEY, time.microsecondsSinceEpoch);
  }
}
