import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({Key? key,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Container(
          width: 32, 
          height: 32, 
          decoration: BoxDecoration(
            color: backGround,
            borderRadius: BorderRadius.circular(8.0), 
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {

                  onPressed!(); 
                },
                child: Container(
                
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/back.svg', 
                    width: 5, 
                    height: 10, 
                  ),
                ),
              ),
            ],
          ),
        
      
    );
  }
}

class BackStepProgressButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const BackStepProgressButton({Key? key,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Container(
          width: 48, 
          height: 48, 
          decoration: BoxDecoration(
            color: colorBlue,
            borderRadius: BorderRadius.circular(10.0), 
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  onPressed!(); 
                },
                child: Container(
                
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    
                  ),
                  child: SvgPicture.asset(
                    'assets/images/chevron-left.svg', 
                    width: 28.8, 
                    height: 28.8, 
                  ),
                ),
              ),
            ],
          ),
        
      
    );
  }
}
