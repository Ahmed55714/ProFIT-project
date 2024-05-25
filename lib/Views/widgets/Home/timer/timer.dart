import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:profit1/utils/colors.dart';

class CountUpTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback onCompleted;

  const CountUpTimer({
    Key? key,
    required this.duration,
    required this.onCompleted,
  }) : super(key: key);

  @override
  CountUpTimerState createState() => CountUpTimerState();
}

class CountUpTimerState extends State<CountUpTimer> {
  Duration elapsed = Duration.zero;
  Timer? timer;
  DateTime? startTime;

  @override
  void initState() {
    super.initState();
    _loadStartTime();
  }

  Future<void> _saveStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('timer_start_time', startTime!.toIso8601String());
  }

  Future<void> _loadStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? startTimeString = prefs.getString('timer_start_time');

    if (startTimeString != null) {
      startTime = DateTime.parse(startTimeString);
      Duration diff = DateTime.now().difference(startTime!);

      if (diff >= widget.duration) {
        elapsed = widget.duration;
        widget.onCompleted();
      } else {
        elapsed = diff;
        startTimer();
      }
    }
  }

  void startTimer() {
    if (timer != null && timer!.isActive) return; // Prevent multiple timers
    startTime = DateTime.now();
    _saveStartTime();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        elapsed = Duration(seconds: elapsed.inSeconds + 1);
        if (elapsed >= widget.duration) {
          timer?.cancel();
          widget.onCompleted();
        }
      });
    });
  }

  void stopTimer() async {
    timer?.cancel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('timer_start_time');
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      elapsed = Duration.zero;
      startTime = DateTime.now();
    });
    _saveStartTime();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = twoDigits(elapsed.inDays);
    final hours = twoDigits(elapsed.inHours.remainder(24));
    final minutes = twoDigits(elapsed.inMinutes.remainder(60));
    final seconds = twoDigits(elapsed.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeSection(time: days, header: 'D', context: context),
        buildTimeDivider(),
        buildTimeSection(time: hours, header: 'H', context: context),
        buildTimeDivider(),
        buildTimeSection(time: minutes, header: 'M', context: context),
        buildTimeDivider(),
        buildTimeSection(time: seconds, header: 'S', context: context),
      ],
    );
  }

  Widget buildTimeDivider() => Text(
        ":",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorBlue,
          fontSize: 24,
        ),
      );

  Widget buildTimeSection(
      {required String time, required String header, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorBlue,
            fontSize: 24,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
          child: Text(
            header,
            style: TextStyle(
              color: colorBlue,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTimeCard({required String time}) {
    return Text(
      time,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorBlue,
        fontSize: 16,
      ),
    );
  }
}

class CountUpTimerController {
  final CountUpTimerState? _state;

  CountUpTimerController(this._state);

  void resetTimer() {
    _state?.resetTimer();
  }

  void startTimer() {
    _state?.startTimer();
  }

  void stopTimer() {
    _state?.stopTimer();
  }
}
