import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

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
          style: const TextStyle(
            color: grey500,
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ),
        const Spacer(),
        Text(
          duration,
          style: const TextStyle(
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
          style: const TextStyle(
            color: blue700,
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ),
        Text(
          ' $value',
          style: const TextStyle(
            color: blue700,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
