import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_bpm/chart.dart';
import 'package:profit1/Views/pages/Features/Heart%20Rate/controller/heart_rate_controller.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/General/customBotton.dart';
import '../../Tabs/BottomNavigationBar/BottomNavigationBar.dart';

class HeartRateScreen extends StatefulWidget {
  @override
  _HeartRateScreenState createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  int? currentHeartRate;
  List<SensorValue> data = [];
  bool isMeasuring = false;
  List<int> recentBPMs = [];
  final HeartRateController heartRateController = Get.put(HeartRateController());

  void _startHeartRateMeasurement() async {
    setState(() {
      data.clear();
      isMeasuring = true;
    });

    await showDialog<void>(
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
            setState(() {
              currentHeartRate = bpm;
              isMeasuring = false;
            });
            _postHeartRateData(bpm);
         Get.offAll(BottomNavigation(role: 'Home', selectedIndex: 0));
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

    setState(() {
      isMeasuring = false;
    });
  }

  Future<void> _postHeartRateData(int bpm) async {
    bool success = await heartRateController.postHeartRateData(bpm);

    if (success) {
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Heart Rate',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildMeasurementContainer(),
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

  Widget _buildMeasurementContainer() {
    return Container(
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
          SvgPicture.asset(
            'assets/svgs/Rate.svg',
            height: 48,
            width: 48,
          ),
          const SizedBox(height: 8),
          _buildBPMReadout(),
          const Divider(indent: 16, endIndent: 16),
          _instructionText(),
          const SizedBox(height: 32),
          _measurementVisualization(),
          _coverCameraText(),
          const SizedBox(height: 126),
        ],
      ),
    );
  }

  Widget _buildBPMReadout() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${currentHeartRate ?? '__'} ',
            style: const TextStyle(
              color: redColor,
              fontSize: 50,
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
    );
  }

  Widget _instructionText() {
    return const Text(
      'Please do not release your finger while testing',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
    );
  }

  Widget _measurementVisualization() {
    if (isMeasuring && data.isNotEmpty) {
      return Container(height: 200, child: BPMChart(data));
    } else {
      return Image.asset('assets/images/hand.png');
    }
  }

  Widget _coverCameraText() {
    return const Text(
      'Fully Cover Flash and Camera with\n one Finger',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colorDarkBlue,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}
