import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../utils/colors.dart';
import '../../../pages/Features/Steps/steps.dart';
import '../../../pages/Tabs/home/Steps/controller/steps_controller.dart';
import '../../BottomSheets/add_challenge.dart';
import '../../General/customBotton.dart';

class CustomInfoCard extends StatefulWidget {
  final String leftIconPath;
  final String rightIconPath;
  final String title;
  final double percentage;
  final Color borderColor;
  final Color titleColor;
  final Color percentageColor;
  final String Text1;
  final double width;
  final double height;
  final bool isShow;
  final bool isShowText2;
  final VoidCallback onTap;

  const CustomInfoCard({
    Key? key,
    required this.leftIconPath,
    required this.rightIconPath,
    required this.title,
    this.percentage = 0.5,
    this.borderColor = Colors.grey,
    this.titleColor = Colors.blue,
    this.percentageColor = Colors.green,
    this.Text1 = '0 Steps | 0.000 Km',
    this.width = 167.5,
    this.height = 123,
    this.isShow = false,
    this.isShowText2 = false,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomInfoCardState createState() => _CustomInfoCardState();
}

class _CustomInfoCardState extends State<CustomInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final StepsController stepsController = Get.put(StepsController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation =
        Tween<double>(begin: 0, end: widget.percentage).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(widget.leftIconPath),
                const SizedBox(width: 4),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: widget.titleColor,
                    fontFamily: 'BoldCairo',
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.onTap();
                  },
                  child: SvgPicture.asset(widget.rightIconPath,
                      color: widget.titleColor),
                ),
              ],
            ),
            widget.isShow
                ? Obx(() {
                    final stepPercentage = (stepsController.steps.value /
                            stepsController.dailyStepGoal.value)
                        .clamp(0.0, 1.0);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${stepsController.steps.value} Steps | ${stepsController.distance.value.toStringAsFixed(3)} Km',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: colorDarkBlue,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(stepPercentage * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: widget.percentageColor,
                                fontFamily: 'BoldCairo',
                              ),
                            ),
                            ActionButton(
                              text: 'Set Goal',
                              onPressed: () =>
                                  _showSubmittedAssessmentConfirmation(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          lineHeight: 6.0,
                          percent: stepPercentage,
                          barRadius: const Radius.circular(6),
                          backgroundColor: widget.borderColor,
                          progressColor: widget.percentageColor,
                        ),
                      ],
                    );
                  })
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.Text1,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: colorDarkBlue,
                        ),
                      ),
                      Text(
                        '${(widget.percentage * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: widget.percentageColor,
                          fontFamily: 'BoldCairo',
                        ),
                      ),
                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        lineHeight: 6.0,
                        percent: widget.percentage,
                        barRadius: const Radius.circular(6),
                        backgroundColor: widget.borderColor,
                        progressColor: widget.percentageColor,
                      ),
                    ],
                  ),
            const SizedBox(height: 8),
            widget.isShowText2
                ? Row(
                    children: [
                      const Spacer(),
                      Text(
                        widget.Text1,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: colorDarkBlue,
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void _showSubmittedAssessmentConfirmation(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.38,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Set New Goal',
                onCancelPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Obx(() {
                  final stepsController = Get.find<StepsController>();
                  return ListView.builder(
                    itemCount: stepsController.stepGoals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${stepsController.stepGoals[index]} Steps'),
                        onTap: () async {
                          await stepsController.setDailyStepGoal(stepsController.stepGoals[index]);
                          Navigator.pop(context); // Close the modal
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
