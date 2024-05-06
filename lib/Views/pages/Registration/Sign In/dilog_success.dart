import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/colors.dart';

class DialogHelper {
  static void showThankYouDialog({
    required BuildContext context,
    String title = "Success!",
    String message = "Thank you!",
    int durationInSeconds = 4,
    double width = 330,
    double height = 300,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: durationInSeconds), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(true);
          }
        });

        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            height: height,
            width: width,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorBlue,
                  ),
                ),
                Row( 
                  children: [
                    Lottie.asset('assets/animations/thank_you.json', width: 150, height: 150),
                      
                 
                  ],
                ),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
