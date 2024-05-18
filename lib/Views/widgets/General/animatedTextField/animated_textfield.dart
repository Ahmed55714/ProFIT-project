import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';
import 'custom_animate_border.dart';

class AnimatedTextField extends StatefulWidget {
  final String label;
  final String? text;
  final Widget? suffix;
  final TextEditingController? controller;

  const AnimatedTextField({
    Key? key,
    required this.label,
    this.text,
    this.suffix,
    this.controller,
  }) : super(key: key);

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> alpha;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    _controller?.addListener(() {
      setState(() {});
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
              border: Border.all(color: grey200),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Theme(
            data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: colorBlue,
                    )),
            child: CustomPaint(
              painter: CustomAnimateBorder(alpha.value),
              child: TextField(
                controller: widget.controller,
                style: const TextStyle(
                  color: DArkBlue900,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                ),
                showCursor: true,
                cursorColor: colorBlue,
                focusNode: focusNode,
                decoration: InputDecoration(
                  label: Text(
                    widget.label,
                    style: TextStyle(
                        color: alpha.value == 1 ? colorBlue : grey500,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Cairo'),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: widget.suffix,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
