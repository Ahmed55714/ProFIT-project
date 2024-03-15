
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../pages/BottomNavigationBar/Home/Map/map.dart';

class RoundedContainerWithRow extends StatelessWidget {
  final String text;
  final String buttonIconPath;
  final String iconPath;

  const RoundedContainerWithRow({
    Key? key,
    required this.text,
    required this.buttonIconPath,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 121,
          decoration: BoxDecoration(
            color: blue600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GymMapScreen()));
                        },
                        icon: SvgPicture.asset(
                          buttonIconPath,
                          color: colorBlue,
                          width: 16,
                          height: 16,
                        ),
                        label: const Text(
                          'Search',
                          style: TextStyle(
                            color: colorBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: colorBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 260,
          child: Container(
            width: 135,
            height: 135,
            decoration: const BoxDecoration(
              color: blue500,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SvgPicture.asset(
                iconPath,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

