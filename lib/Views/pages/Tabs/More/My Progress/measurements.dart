import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/utils/colors.dart';

class Measurements extends StatelessWidget {
  const Measurements({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24.0),
      child: ListView(
        children: [
          _buildMeasurementContainer('Body Weight', 'assets/svgs/progress.svg', [
            _buildWeightRow('72 ', 'Kg', '31 December, 2023'),
            _buildDivider(),
            _buildWeightRow('73 ', 'Kg', '20 December, 2023'),
            _buildDivider(),
            _buildWeightRow('75 ', 'Kg', '18 November, 2023'),
          ]),
          SizedBox(height: 16),
          _buildMeasurementContainer('Body Fat', 'assets/svgs/bodyFat.svg', [
            _buildWeightRow('20 ', '%', '31 December, 2023'),
            _buildDivider(),
            _buildWeightRow('21 ', '%', '20 December, 2023'),
            _buildDivider(),
            _buildWeightRow('23 ', '%', '18 November, 2023'),
          ]),
          SizedBox(height: 16),
          _buildMeasurementContainer('Waist Area', 'assets/svgs/waistArea.svg', [
            _buildWeightRow('20 ', '%', '31 December, 2023'),
            _buildDivider(),
            _buildWeightRow('21 ', '%', '20 December, 2023'),
            _buildDivider(),
            _buildWeightRow('23 ', '%', '18 November, 2023'),
          ]),
          SizedBox(height: 16),
          _buildMeasurementContainer('Neck Area', 'assets/svgs/neckArea.svg', [
            _buildWeightRow('20 ', '%', '31 December, 2023'),
            _buildDivider(),
            _buildWeightRow('21 ', '%', '20 December, 2023'),
            _buildDivider(),
            _buildWeightRow('23 ', '%', '18 November, 2023'),
          ]),
        ],
      ),
    );
  }

  Widget _buildMeasurementContainer(
      String title, String assetPath, List<Widget> rows) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: grey200,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(assetPath),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CairoBold',
                  color: colorDarkBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildWeightRow(String weight, String weight2, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: weight,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CairoBold',
                  color: colorBlue,
                ),
              ),
              TextSpan(
                text: weight2,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'CairoBold',
                  color: colorBlue,
                ),
              ),
            ],
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: grey500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(
        height: 1,
        color: Colors.grey[300],
      ),
    );
  }
}
