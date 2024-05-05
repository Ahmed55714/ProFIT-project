import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class CustomLoder extends StatelessWidget {


  const CustomLoder({
    Key? key,
   

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SpinKitPulsingGrid (
  color: Colors.white,
  size: 25.0,
),
    );
  }
}
