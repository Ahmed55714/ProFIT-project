import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../General/customBotton.dart';
import '../timer/timer.dart';

class ExpandedContent extends StatefulWidget {
  final String title;
  final VoidCallback onGiveUpPressed;

  const ExpandedContent({
    Key? key,
    required this.title,
    required this.onGiveUpPressed,
  }) : super(key: key);

  @override
  _ExpandedContentState createState() => _ExpandedContentState();
}

class _ExpandedContentState extends State<ExpandedContent> {
  bool showDelayedContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          showDelayedContent = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 14,
                    color: colorBlue,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          if (showDelayedContent) ...[
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'try to stick the challenge for at least 21 days',
                    style: TextStyle(
                        fontSize: 11,
                        color: grey500,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  text: 'Give up!',
                  onPressed: widget.onGiveUpPressed,
                  isShowIcon: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CountUpTimer(
                    duration: const Duration(days: 1000),
                    onCompleted: () {
                      print('CountUpTimer Completed');
                    },
                  ),
                ),
              ],
            ),
          
          ],
        ],
      ),
    );
  }
}
