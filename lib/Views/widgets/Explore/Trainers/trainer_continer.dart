// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:profit1/utils/colors.dart';

import '../Trainer Details/trainer_details.dart';

class TrainerCard extends StatefulWidget {
  const TrainerCard({Key? key}) : super(key: key);

  @override
  State<TrainerCard> createState() => _TrainerCardState();
}

class _TrainerCardState extends State<TrainerCard> {
  bool isLoved = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TrainerDetails(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
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
                  icon: isLoved
                      ? SvgPicture.asset('assets/svgs/love1.svg')
                      : SvgPicture.asset('assets/svgs/love.svg'),
                  onPressed: () {
                    setState(() {
                      isLoved = !isLoved;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceAndPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ExperienceWidget(
          isShowSvg: true,
        ),
        const Spacer(),
        const PriceWidget(),
        const SizedBox(width: 16),
        SvgPicture.asset('assets/svgs/chevron-right.svg'),
      ],
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
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '4.3 ',
                style: TextStyle(
                  color: green500,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: '(119)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    this.priceText = '1,650 EGP',
  }) : super(key: key);

  final String priceText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'From ',
            style: TextStyle(
              color: colorDarkBlue,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
          TextSpan(
            text: priceText,
            style: const TextStyle(
              color: colorBlue,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceWidget extends StatelessWidget {
  final String? text;
  final String? text2;
  final bool isShowSvg;
  final String svg;

  const ExperienceWidget({
    Key? key,
    this.text,
    this.text2,
    this.isShowSvg = true,
    this.svg = 'assets/svgs/trophy.svg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: isShowSvg,
          child: SvgPicture.asset(svg),
        ),
        SizedBox(width: isShowSvg ? 8 : 0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text ?? 'Experience ',
                style: const TextStyle(
                  color: colorDarkBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
              ),
              TextSpan(
                text: text2 ?? '7 Years',
                style: const TextStyle(
                  color: colorDarkBlue,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'BoldCairo',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
