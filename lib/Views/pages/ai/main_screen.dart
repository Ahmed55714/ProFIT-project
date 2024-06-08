import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../../utils/colors.dart';
import 'pushed_pageA.dart';
import 'pushed_pageS.dart';
import 'pushed_pageY.dart';

class MainScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  MainScreen(this.cameras);

  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              headerText('My AI', colorBlue, 28.0),
              headerText('Master Your Body Alignment', DArkBlue900, 18.0),
              SizedBox(height: 10),
              Image.asset('assets/images/align.PNG'),
              SizedBox(height: 10),
              SizedBox(height: 20),
              headerText('Strength Alignment', DArkBlue900, 24.0),
              buildScrollableList(context, 6, false),
              SizedBox(height: 15.0),
              headerText('Yoga Alignment', DArkBlue900, 24.0),
              buildScrollableList(context, 5, true),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerText(String text, Color color, double fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget buildScrollableList(BuildContext context, int count, bool isYoga) {
    return Container(
      height: 150,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (context, index) => isYoga ? buildYogaButton(context, index) : buildButton(context, index),
      ),
    );
  }

  Widget buildButton(BuildContext context, int index) {
    List<String> images = ['crunch.PNG', 'arm_press.PNG', 'push_up.PNG', 'squat.PNG', 'plank.PNG', 'lunge_squat.PNG'];
    List<void Function()?> actions = [
      () => print('hello'), 
      () => onSelectA(context: context, modelName: 'posenet'),
      () => print('hello'),
      () => onSelectS(context: context, modelName: 'posenet'),
      () => print('hello'),
      () => print('hello')
    ];

    return actionButton(images[index], actions[index]);
  }

  Widget buildYogaButton(BuildContext context, int index) {
    List<String> images = ['yoga1.PNG', 'yoga4.PNG', 'yoga2.PNG', 'yoga3.PNG', 'yoga5.PNG'];
    List<void Function()?> actions = [
      () => print('hello'),
      () => onSelectY(context: context, modelName: 'posenet'),
      () => print('hello'), 
      () => print('hello'),
      () => print('hello'),
    ];

    return actionButton(images[index], actions[index]);
  }

  Widget actionButton(String image, void Function()? action) {
    return Stack(
      children: <Widget>[
        Container(
          width: 140,
          height: 140,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              primary: Colors.white,
            ),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Image.asset('assets/images/$image'),
            ),
            onPressed: action,
          ),
        ),
      ],
    );
  }

  void onSelectA({required BuildContext context, required String modelName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PushedPageA(cameras: cameras, title: modelName),
      ),
    );
  }

  void onSelectS({required BuildContext context, required String modelName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PushedPageS(cameras: cameras, title: modelName),
      ),
    );
  }

  void onSelectY({required BuildContext context, required String modelName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PushedPageY(cameras: cameras, title: modelName),
      ),
    );
  }
}
