import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

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
      body: const Column(
        children: [
          SizedBox(height: 16),
          CongratulationsWidget(
            description: '21 Day without Fast Food',
          ),
          SizedBox(height: 16),
          CongratulationsWidget(
            description: '15 Liters of Water',
          ),
          SizedBox(height: 16),
          CongratulationsWidget(
            description: '10,000 Steps',
          ),
        ],
      ),
    );
  }
}

class CongratulationsWidget extends StatelessWidget {
  final String description;

  const CongratulationsWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/images/madel.png'),
          const SizedBox(height: 16),
          const Text(
            'Congratulations',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: blue700,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: DArkBlue900,
            ),
          ),
        ],
      ),
    );
  }
}





