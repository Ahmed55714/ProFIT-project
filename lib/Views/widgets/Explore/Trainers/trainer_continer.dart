// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:profit1/utils/colors.dart';

import '../../../pages/Explore/Trainer Details/trainer_details.dart';
import '../../../pages/Tabs/Explore/model/trainer.dart';

class TrainerCard extends StatefulWidget {
  final Trainer? trainer;

  const TrainerCard({
    Key? key,
    this.trainer,
  }) : super(key: key);

  @override
  State<TrainerCard> createState() => _TrainerCardState();
}

class _TrainerCardState extends State<TrainerCard> {
  bool isLoved = false;
  @override
  Widget build(BuildContext context) {
    Trainer trainer = widget.trainer!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrainerDetails(trainer: trainer, trainerId: trainer.id,),
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
                          child: trainer.profilePhoto != null
                              ? Image.network(
                                  trainer.profilePhoto!,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset('assets/images/trainer.png',
                                          fit: BoxFit.cover),
                                )
                              : Image.asset('assets/images/trainer.png',
                                  fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingWidget(
                                  rate:
                                      trainer.averageRating.toStringAsFixed(1),
                                      rate2: trainer.subscribers.toStringAsFixed(0),),
                                      
                              Text(
                                trainer.fullName ?? ' ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19,
                                  color: colorDarkBlue,
                                ),
                              ),
                              Text(
                                trainer.specializations.join(', ') ??
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
                    _buildExperienceAndPriceRow(trainer.yearsOfExperienceText,
                        trainer.lowestPrice.toStringAsFixed(0)),
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

  Widget _buildExperienceAndPriceRow(String years, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ExperienceWidget(
          isShowSvg: true,
          text2: years,
        ),
        const Spacer(),
        PriceWidget(priceText: price),
        const SizedBox(width: 16),
        SvgPicture.asset('assets/svgs/chevron-right.svg'),
      ],
    );
  }
}

class RatingWidget extends StatelessWidget {
  final String? rate;
  final String? rate2;

  RatingWidget({
    Key? key,
    this.rate,
    this.rate2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SvgPicture.asset('assets/svgs/Star.svg'),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${rate ?? 'N/A'} ",
                style: TextStyle(
                  color: green500,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              WidgetSpan(
                child: SizedBox(width: 3),
              ),
              TextSpan(
                text:  "${rate2  ?? '(119)'} ",
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
  bool isPay;
  PriceWidget({
    Key? key,
    this.priceText = '1,650 EGP',
    this.isPay = false,
  }) : super(key: key);

  final String priceText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (!isPay)
            const TextSpan(
              text: 'From ',
              style: TextStyle(
                color: colorDarkBlue,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
          WidgetSpan(
            child: SizedBox(width: 3),
          ),
          TextSpan(
            text: priceText ?? '0',
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
  final Color color;
  final bool isFit;

  const ExperienceWidget({
    Key? key,
    this.text,
    this.text2,
    this.isShowSvg = true,
    this.svg = 'assets/svgs/trophy.svg',
    this.color = colorDarkBlue,
    this.isFit = false,
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
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
              ),
              TextSpan(
                text: text2 ?? '0 years',
                style: TextStyle(
                  color: color,
                  fontWeight: isFit ? FontWeight.bold : FontWeight.w400,
                  fontFamily: isFit ? 'BoldCairo' : 'Cairo',
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
