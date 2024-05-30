import 'dart:async';
import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

class CountUpTimer extends StatefulWidget {
  final DateTime startTime;
  final VoidCallback onCompleted;

  const CountUpTimer({
    Key? key,
    required this.startTime,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _CountUpTimerState createState() => _CountUpTimerState();
}

class _CountUpTimerState extends State<CountUpTimer> {
  Duration elapsed = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        elapsed = DateTime.now().difference(widget.startTime);
        if (elapsed >= Duration(days: 1000)) { // You can set any duration you want
          timer?.cancel();
          widget.onCompleted();
        }
      });
    });
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

  Widget buildTimeSection({required String time, required String header, required BuildContext context}) {
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
}
