import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../utils/colors.dart';
import '../../../pages/Features/Steps/steps.dart';

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
    this.Text1 = 'View Details',
    this.width = 167.5,
    this.height = 123,
    this.isShow = false,
      required this.onTap,
    }) : super(key: key);

  @override
  _CustomInfoCardState createState() => _CustomInfoCardState();
}

class _CustomInfoCardState extends State<CustomInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
                ? const Text(
                    '176 Step | 0.009 Km',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: colorDarkBlue,
                    ),
                  )
                : Container(),
            Text(
              '${(_animation.value * 100).toStringAsFixed(0)}%',
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
              percent: _animation.value,
              barRadius: const Radius.circular(6),
              backgroundColor: widget.borderColor,
              progressColor: widget.percentageColor,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Spacer(),
                Text(
                  '${widget.Text1}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: colorDarkBlue,
                  ),
                ),
              ],
            )
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
