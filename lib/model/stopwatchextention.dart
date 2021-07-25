class StopWatchExtended extends Stopwatch {
  int startMicroseconds = 0;

  StopWatchExtended();

  get elapsedExtended {
    return Duration(microseconds: elapsedMicroseconds + startMicroseconds);
  }

  get elapsedMicrosecondsExtended {
    return elapsedMicroseconds + startMicroseconds;
  }

  setStartMicroseconds(int micro) {
    startMicroseconds = micro;
  }

  void resetExtended() {
    reset();
    startMicroseconds = 0;
  }
}
