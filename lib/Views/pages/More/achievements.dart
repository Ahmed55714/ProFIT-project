import 'package:flutter/material.dart';

import '../../widgets/AppBar/custom_appbar.dart';

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Achievements',
        isShowFavourite: true,
        isShowProfile: true,
      ),
      body: Column(),
    );
  }
}