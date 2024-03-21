import 'package:flutter/material.dart';

import '../../widgets/AppBar/custom_appbar.dart';

class DietScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        titleText: 'Diet',
        isShowExplore: true,
      ),
      body:Padding(
        padding: const EdgeInsets.only(left:16, right:16, top:16),
        child: Column(
          children: [
            Image.asset('assets/images/Component5.png'),
            
          ],),
      ),
    );
  }
}