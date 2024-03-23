import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/utils/colors.dart';

class StartWorkout extends StatefulWidget {
  const StartWorkout({super.key});

  @override
  State<StartWorkout> createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  Duration duration = Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 3600) {
        // Stops the timer when it reaches 1 hour
        duration = Duration(seconds: seconds);
      } else {
        timer?.cancel();
      }
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
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    // Calculate the percentage based on the duration.
    final double percent = duration.inSeconds / 3600;

    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Workout Session',
        showContainer: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Workout Duration',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: blue700,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$hours:$minutes:$seconds",
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w700,
                    color: red600,
                  )),
            ],
          ),
          SizedBox(height: 8),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: LinearPercentIndicator(
                lineHeight: 10.0,
                percent: percent, 
                backgroundColor: Colors.grey.shade300,
                progressColor: green400,
                barRadius: const Radius.circular(10),
              ),
         ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,),
            child: Row(
              children: [
                Text('1/7 Exercises Finished',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: grey500,
                    )),
              ],
            ),
          ),
       
          VideoThumbnail(
  imagePath: 'assets/images/work.png', 
  onPlayPressed: () {
    // Handle play button press
    print('Play button pressed!');
  },
)

        ],
      ),
    );
  }
}



class VideoThumbnail extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPlayPressed;

  const VideoThumbnail({
    Key? key,
    required this.imagePath,
    required this.onPlayPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/playVedio.png',
                )
            ),
          ),
        ),
      ),
    );
  }
}
