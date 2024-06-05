import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import '../../../../../../services/api_service.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../widgets/BottomSheets/progress/photo.dart';
import '../../../../../widgets/General/customBotton.dart';
import 'package:intl/intl.dart';

import 'controller/controller.dart';

class Measurements extends StatelessWidget {
  const Measurements({super.key});

  String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    final formattedDate = DateFormat('dd MMMM, yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final measurementsController = Get.put(MeasurementsController(ApiService()));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24.0),
        child: Obx(() {
          if (measurementsController.isLoading.value) {
            return Center(
              child: CustomLoder(
                color: colorBlue,
                size: 35,
              ),
            );
          } else if (measurementsController.errorMessage.isNotEmpty) {
            return Center(child: Text(measurementsController.errorMessage.value));
          } else {
            final measurements = measurementsController.measurements.value;
            return ListView(
              children: [
                _buildMeasurementContainer(
                  'Body Weight',
                  'assets/svgs/progress.svg',
                  measurements.weight.map((m) => _buildWeightRow('72 ', 'Kg', formatDate(m.createdAt))).toList(),
                ),
                SizedBox(height: 16),
                _buildMeasurementContainer(
                  'Body Fat',
                  'assets/svgs/bodyFat.svg',
                  measurements.bodyFat.map((m) => _buildWeightRow('20 ', '%', formatDate(m.createdAt))).toList(),
                ),
                SizedBox(height: 16),
                _buildMeasurementContainer(
                  'Waist Area',
                  'assets/svgs/waistArea.svg',
                  measurements.waistArea.map((m) => _buildWeightRow('20 ', '%', formatDate(m.createdAt))).toList(),
                ),
                SizedBox(height: 16),
                _buildMeasurementContainer(
                  'Neck Area',
                  'assets/svgs/neckArea.svg',
                  measurements.neckArea.map((m) => _buildWeightRow('20 ', '%', formatDate(m.createdAt))).toList(),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildMeasurementContainer(String title, String assetPath, List<Widget> rows) {
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
                  fontFamily: 'BoldCairo',
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
                  fontFamily: 'BoldCairo',
                  color: colorBlue,
                ),
              ),
              TextSpan(
                text: weight2,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'BoldCairo',
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
