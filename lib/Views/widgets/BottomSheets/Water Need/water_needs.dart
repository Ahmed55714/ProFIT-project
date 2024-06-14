import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';
import '../../CircularIndicator/circular_indicator.dart';


class WaterNeedsWidget extends StatefulWidget {
  final double currentIntakeML;
  final double goalIntakeML;

  const WaterNeedsWidget({Key? key, required this.currentIntakeML, required this.goalIntakeML}) : super(key: key);

  @override
  _WaterNeedsWidgetState createState() => _WaterNeedsWidgetState();
}

class _WaterNeedsWidgetState extends State<WaterNeedsWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: (widget.currentIntakeML / widget.goalIntakeML).clamp(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(WaterNeedsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIntakeML != widget.currentIntakeML || oldWidget.goalIntakeML != widget.goalIntakeML) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: (widget.currentIntakeML / widget.goalIntakeML).clamp(0.0, 1.0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${widget.currentIntakeML.toInt()} ML \n',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: wirdColor, fontFamily: 'BoldCairo'),
              ),
              TextSpan(
                text: '/ ${widget.goalIntakeML.toInt()} ML',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: wirdColor),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CircularIndicatorWithIconAndText(
              percentage: _animation.value,
              backgroundColor: Colors.grey[200]!,
              progressColor: wirdColor,
              iconName: 'assets/svgs/dropletwater.svg',
              percentageText: '${(_animation.value * 100).toInt()}%',
            );
          },
        ),
      ],
    );
  }
}
