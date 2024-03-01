import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_bpm/chart.dart';
import 'package:profit1/Views/widgets/customBotton.dart';
import 'package:profit1/utils/colors.dart';
import '../HomeScreens/Home.dart'; // Ensure this path is correct for your project structure

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
      appBar: CustomAppBar(titleText: 'Heart Rate'),
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

  // AppBar _buildAppBar() {
  //   return AppBar(
  //     leading: IconButton(
  //       icon: const Icon(Icons.close, color: colorBlue, size: 24),
  //       onPressed: () =>
  //       Navigator.pop(context)
  //       //  Navigator.pushReplacement(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => HomeScreen(heartRate: currentHeartRate)), // Ensure this navigates as expected
  //       // ),
  //     ),
  //     title: const Text('Heart Rate', style: TextStyle(color: colorBlue, fontSize: 23, fontWeight: FontWeight.w700)),
  //     backgroundColor: Colors.white,
  //     elevation: 0.5,
  //   );
  // }

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
              offset: const Offset(0, 3))
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
          SizedBox(height: 32),
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
                fontFamily: 'BoldCairo'),
          ),
          const TextSpan(
              text: 'BPM',
              style: TextStyle(
                  color: redColor, fontSize: 19, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _instructionText() {
    return const Text(
      'Please do not release your finger while testing',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 13),
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
          color: colorDarkBlue, fontWeight: FontWeight.w400, fontSize: 16),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool showContainer;
  final String? dropdownValue;
  final ValueChanged<String?>?
      onDropdownChanged; 

  const CustomAppBar({
    Key? key,
    required this.titleText,
    this.showContainer = false,
    this.dropdownValue,
    this.onDropdownChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close, color: colorBlue, size: 24),
        onPressed: () => Navigator.pop(context),
      ),
      title: Transform.translate(
        offset: const Offset(-19, 0),
        child: Text(
          titleText,
          style: const TextStyle(
            color: colorBlue,
            fontSize: 23,
            fontWeight: FontWeight.w700,
            fontFamily: 'BoldCairo',
          ),
        ),
      ),
      actions: showContainer
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 120,
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: backgroundBlue,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorBlue),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: SvgPicture.asset(
                          'assets/svgs/Chevron-Left.svg'), // const Icon(Icons.arrow_drop_down, color: colorBlue, size: 24,
                      iconSize: 24,
                      elevation: 1,
                      borderRadius:  BorderRadius.circular(8),
                      style: const TextStyle(
                        color: colorBlue,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: onDropdownChanged,
                      items: <String>['Last 7 Days', 'Last 30 Days', 'All Time']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ]
          : null,
      backgroundColor: Colors.white,
      elevation: 0.5,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default AppBar height
}
