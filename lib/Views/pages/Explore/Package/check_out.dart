// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Explore/Trainers/trainer_continer.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Checkout',
        showContainer: true,
       
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: grey200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    width: 75,
                                    height: 75,
                                    child: Image.asset(
                                      'assets/images/trainer.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ahmed Tarek',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                          color: colorDarkBlue,
                                        ),
                                      ),
                                      DurationWidget(
                                        label: 'Subscription Type',
                                        duration: 'Diet & Workout',
                                      ),
                                      DurationWidget(
                                        label: 'Duration',
                                        duration: '3 Months',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                StartAtWidget(
                                  label: 'Start at :',
                                  value: '17 January 2024',
                                ),
                                Spacer(),
                                StartAtWidget(
                                  label: 'End at : ',
                                  value: '17 March 2024',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 263),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CustomTextField(
                labelText: 'Enter Coupon Code',
                fieldHeight: 44,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/svgs/offer.svg'),
                ),
                isShowButton: true,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: grey200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const ExperienceWidget(
                            isShowSvg: false,
                            text: 'Sub-Total',
                            color: grey400,
                            text2: '',
                          ),
                          Spacer(),
                          const ExperienceWidget(
                            isShowSvg: false,
                            text: '1,650 ',
                            color: DArkBlue900,
                            text2: 'EGP',
                            isFit: true,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const ExperienceWidget(
                            isShowSvg: false,
                            text: 'VAT',
                            color: grey400,
                            text2: '',
                          ),
                          Spacer(),
                          const ExperienceWidget(
                            isShowSvg: false,
                            text: '1,650 ',
                            color: DArkBlue900,
                            text2: 'EGP',
                            isFit: true,
                          ),
                        ],
                      ),
                      const Divider(color: grey200, thickness: 1),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              color: grey500,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          PriceWidget(
                            isPay: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(text: 'Pay Now', onPressed: () {}),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class DurationWidget extends StatelessWidget {
  final String label;
  final String duration;
  const DurationWidget({
    Key? key,
    required this.label,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: grey500,
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ),
        Spacer(),
        Text(
          duration,
          style: TextStyle(
            color: grey500,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class StartAtWidget extends StatelessWidget {
  final String label;
  final String value;

  const StartAtWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: blue700,
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ),
        Text(
          ' $value',
          style: TextStyle(
            color: blue700,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
