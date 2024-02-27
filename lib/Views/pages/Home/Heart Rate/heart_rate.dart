import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/Views/widgets/customBotton.dart';
import 'package:profit1/utils/colors.dart';

class HeartRateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: colorBlue, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Heart Rate',
          style: TextStyle(color: colorBlue, fontSize: 23, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 6,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 32),
                    SvgPicture.asset('assets/svgs/Rate.svg'),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '91 ',
                            style: TextStyle(
                              color: redColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'BoldCairo',
                            ),
                          ),
                          TextSpan(
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
                    Divider(indent: 16, endIndent: 16),
                    Text(
                      'Please do not release your finger while testing',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 40),
                    Image.asset('assets/images/hand.png'),
                    SizedBox(height: 16),
                    Text(
                      'Fully Cover Flash and Camera with one Finger',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorDarkBlue,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 126), 
                  ],
                ),
              ),
              CustomButton(text: '90%', onPressed: () {}),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
