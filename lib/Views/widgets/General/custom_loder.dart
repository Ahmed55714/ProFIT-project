// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoder extends StatelessWidget {
  Color color;


   CustomLoder({
    Key? key,
     this.color= Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SpinKitPulsingGrid (
  color: color,
  size: 25.0,
),
    );
  }
}
