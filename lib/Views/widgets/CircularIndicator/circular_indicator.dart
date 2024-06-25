import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../utils/colors.dart';

class CircularIndicatorWithIconAndText extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final String iconName;
  final String percentageText;
  final String total;
  final String kal;
  final bool isShowDiet;

  const CircularIndicatorWithIconAndText({
    Key? key,
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.iconName,
     this.percentageText= '50%',
     this.total = '975',
     this.kal = '/1966 Kcal',
    this.isShowDiet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 8.0,
      percent: percentage,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            iconName,
          ),
          isShowDiet
              ? Column(
                  children: [
                    Text(
                      total,
                      style: TextStyle(
                        color: blue700,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    SvgPicture.asset('assets/svgs/FlameRed.svg'),
                    Text(
                      kal,
                      style: TextStyle(
                        color: blue700,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                )
              : Text(
                  percentageText,
                  style: const TextStyle(
                    color: wirdColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 19.0,
                  ),
                ),
        ],
      ),
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}




class DietProgressWidget extends StatefulWidget {
  final String iconAsset;
  final String label;
  final String progressText;
  final double progressPercent;

  const DietProgressWidget({
    Key? key,
    required this.iconAsset,
    required this.label,
    required this.progressText,
    required this.progressPercent,
  }) : super(key: key);

  @override
  _DietProgressWidgetState createState() => _DietProgressWidgetState();
}

class _DietProgressWidgetState extends State<DietProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late double _oldProgressPercent;

  @override
  void initState() {
    super.initState();

    _oldProgressPercent = widget.progressPercent;

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progressPercent,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant DietProgressWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progressPercent != widget.progressPercent) {
      _oldProgressPercent = oldWidget.progressPercent;

      _animation = Tween<double>(
        begin: _oldProgressPercent,
        end: widget.progressPercent,
      ).animate(_animationController)
        ..addListener(() {
          setState(() {});
        });

      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(widget.iconAsset),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: DArkBlue900,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.progressText,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: blue700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 6.0,
            percent: _animation.value,
            barRadius: const Radius.circular(6),
            backgroundColor: grey200,
            progressColor: blue500,
          ),
        ],
      ),
    );
  }
}
