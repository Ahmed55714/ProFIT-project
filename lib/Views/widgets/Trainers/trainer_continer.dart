import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: grey200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/trainer.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingWidget(),
                          SizedBox(height: 8),
                          Text(
                            'Ahmed Tarek',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                              color: colorDarkBlue,
                            ),
                          ),
                          Text(
                            'Body Building, CrossFit, Fitness',
                            style: TextStyle(
                              color: grey500,
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: grey200, thickness: 1),
                const SizedBox(height: 10),
                _buildExperienceAndPriceRow(),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: SvgPicture.asset('assets/svgs/love.svg'),
              onPressed: () {
                // Handle favorite toggle
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceAndPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildExperience(),
        _buildPrice(),
        SvgPicture.asset('assets/svgs/chevron-right.svg'),
      ],
    );
  }

  Widget _buildExperience() {
    return Row(
      children: [
        SvgPicture.asset('assets/svgs/trophy.svg'),
        const SizedBox(width: 8),
        const Text(
          'Experience 3 Years',
          style: TextStyle(
            color: colorDarkBlue,
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return const Text(
      'From 1,650 EGP',
      style: TextStyle(
        color: colorBlue,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SvgPicture.asset('assets/svgs/Star.svg'),
        const SizedBox(width: 4),
        const Text(
          '4.3 (119)',
          style: TextStyle(
            color: green500,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
