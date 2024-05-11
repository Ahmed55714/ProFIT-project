// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoder extends StatelessWidget {
  Color color;
  int size;

  CustomLoder({
    Key? key,
    this.color = Colors.white,
    this.size = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPulsingGrid(
        color: color,
        size: size.toDouble(),
      ),
    );
  }
}
