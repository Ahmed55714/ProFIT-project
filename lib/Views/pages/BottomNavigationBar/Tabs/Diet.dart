import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Diet/custom_diet_continer.dart';
import '../../../widgets/Explore/Filters/custom_filter.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';



class DietScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: const CustomAppBar(
        titleText: 'Diet',
        showContainer: true,
        isShowNormal: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  Container(
                    height: 125,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/combo.jpeg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              transform: const GradientRotation(0.6),
                              stops: const [0.4, 1.0],
                              begin: Alignment.centerLeft,
                              end: Alignment.topRight,
                              colors: [
                                const Color(0xFF006635).withOpacity(0.66),
                                const Color(0xFF000000).withOpacity(0.3),
                              ],
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 23,
                              top: 3,
                              right: 22,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ProFIT Free Diet Plans',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Unlock your journey to a healthier you with our free diet plans crafted by expert trainers available exclusively on our platform.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
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
                          const CustomLabelWidget(
                            title: 'Your Daily Need',
                            isPadding: true,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
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
                                    const SizedBox(width: 8),
                                    const Text(
                                      '1975',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                          color: blue700),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
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
                          const Row(
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
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const CustomLabelWidget(
                        title: 'Recommended Diet Plans',
                        isPadding: true,
                      ),
                      const Spacer(),
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
            FilterBar(
              onFilterSelected: (String) {},
              filters: const [
                'All',
                'Vegan',
                'Balanced',
                'PSMF',
                'Keto',
                'CarbCycle',
                'Low Carb'
              ],
            ),
            const SizedBox(height: 16),
              ...List.generate(
                2,
                (index) => Column(
                  children: [
                    FreeDiet(isShowCard: true ,key: ValueKey(index)),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}


















