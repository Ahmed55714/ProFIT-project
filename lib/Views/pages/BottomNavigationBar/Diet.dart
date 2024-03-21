import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/utils/colors.dart';

import '../../widgets/AppBar/custom_appbar.dart';

class DietScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'Diet',
        isShowExplore: true,
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                child: Image.asset('assets/images/Component5.png')),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomLabelWidget(
                      title: 'Your Daily Need',
                      isPadding: true,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: blue50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/Flame.png'),
                              SizedBox(width: 8),
                              Text(
                                '1975',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: blue700),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Kcal',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: blue700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDietContainer(
                            quantity: '98g',
                            label: 'Protein',
                            svgAsset: 'assets/svgs/diett.svg',
                          ),
                        ),
                        Expanded(
                          child: CustomDietContainer(
                            quantity: '65g',
                            label: 'Fats',
                            svgAsset: 'assets/svgs/waterdrops.svg',
                          ),
                        ),
                        Expanded(
                          child: CustomDietContainer(
                            quantity: '98g',
                            label: 'Protein',
                            svgAsset: 'assets/svgs/break.svg',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                CustomLabelWidget(
                  title: 'Recommended Diet Plans',
                  isPadding: true,
                ),
                Spacer(),
                  const Text(
                    'See More',
                    style: TextStyle(
                      color: colorDarkBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SvgPicture.asset('assets/svgs/chevron-small-right.svg')
              ],
            ),
            SizedBox(height: 16),
            
          ],
        ),
      ),
    );
  }
}

class CustomDietContainer extends StatelessWidget {
  final String quantity;
  final String label;
  final String svgAsset;

  const CustomDietContainer({
    Key? key,
    required this.quantity,
    required this.label,
    required this.svgAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(16),
        width: 98,
        decoration: BoxDecoration(
          color: grey50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quantity,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: blue700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: DArkBlue900,
                  ),
                ),
              ],
            ),
            Spacer(),
            SvgPicture.asset(svgAsset),
          ],
        ),
      ),
    );
  }
}
