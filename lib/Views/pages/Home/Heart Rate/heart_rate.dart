import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_bpm/chart.dart';
import 'package:profit1/Views/widgets/customBotton.dart';
import 'package:profit1/utils/colors.dart';
import '../HomeScreens/Home.dart';

class HeartRateScreen extends StatefulWidget {
  @override
  _HeartRateScreenState createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  int? currentHeartRate;
  List<SensorValue> data = [];
  bool isMeasuring = false;
  List<int> recentBPMs = [];

  void _startHeartRateMeasurement() async {
    setState(() {
      data.clear();
      isMeasuring = true;
    });

    var dialogResult = await showDialog<int>(
      context: context,
      builder: (context) => HeartBPMDialog(
        context: context,
        onBPM: (bpm) {
          recentBPMs.add(bpm);
          if (recentBPMs.length > 3) {
            recentBPMs.removeAt(0);
          }

          if (recentBPMs.length == 3 &&
              recentBPMs.every((bpm) => bpm >= 60 && bpm <= 100)) {
            Navigator.of(context).pop(bpm);
          } else {
            setState(() {
              currentHeartRate = bpm;
            });
          }
        },
        sampleDelay: 2000 ~/ 30,
        onRawData: (SensorValue value) {
          setState(() {
            data.add(value);
          });
        },
      ),
    );

    if (dialogResult != null && dialogResult >= 60 && dialogResult <= 100) {
      setState(() {
        currentHeartRate = dialogResult;
        isMeasuring = false;
      });
    } else {
      setState(() {
        isMeasuring = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: colorBlue, size: 24),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(heartRate: currentHeartRate),
            ),
          ),
        ),
        title: const Text('Heart Rate',
            style: TextStyle(
                color: colorBlue, fontSize: 23, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 6,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 32),
                    SvgPicture.asset('assets/svgs/Rate.svg', height: 120),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${currentHeartRate ?? '--'} ',
                            style: const TextStyle(
                              color: redColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'BoldCairo',
                            ),
                          ),
                          const TextSpan(
                            text: 'BPM',
                            style: TextStyle(
                              color: redColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    const SizedBox(height: 16),
                    const Text(
                      'Please do not release your finger while testing',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    if (isMeasuring && data.isNotEmpty) ...[
                      Container(
                        height: 200,
                        child: BPMChart(data),
                      ),
                      const SizedBox(height: 16),
                    ] else if (!isMeasuring) ...[
                      Image.asset('assets/images/hand.png'),
                      const SizedBox(height: 40),
                    ],
                    const Text(
                      'Fully Cover Flash and Camera with one Finger',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorDarkBlue,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 126),
                  ],
                ),
              ),
              CustomButton(
                text: isMeasuring ? 'Stop Measurement' : 'Start Measurement',
                onPressed: _startHeartRateMeasurement,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
