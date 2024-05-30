import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_loder.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isShowIcon;
  final String? icon;
  final bool isShowSmall;
  final bool isShowDifferent;
  final bool subscription;
  final bool isLoading;
  final bool isPadding;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isShowIcon = false,
    this.icon,
    this.isShowSmall = false,
    this.isShowDifferent = false,
    this.subscription = false,
    this.isLoading = false,
    this.isPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPadding ? 0 : 16),
      child: ElevatedButton(
        onPressed: onPressed != null && !isLoading ? onPressed : null,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(_getTextColor()),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          
            return _getButtonBackgroundColor(); 
          }),
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(Size(isShowSmall ? 111 : double.infinity, 48)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isShowDifferent ? BorderSide(color: colorBlue) : BorderSide.none,
          )),
        ),
        child: isLoading ? CustomLoder() : _buildButtonChild(),
      ),
    );
  }





  Widget _buildButtonChild() {
    return isShowIcon && icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: _getTextColor(),
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(icon!),
            ],
          )
        : Text(
            text,
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'BoldCairo',
              fontWeight: FontWeight.bold,
              color: _getTextColor(),
            ),
          );
  }

  Color _getButtonBackgroundColor() {
    if (isShowDifferent) return Colors.white;
    return subscription ? red100 : (isShowIcon ? backgroundBlue : colorBlue);
  }

  Color _getTextColor() {
    return subscription ? red600 : (isShowDifferent ? colorBlue : Colors.white);
  }
}


class ActionButton extends StatelessWidget {
  final String text;
  final bool isShowIcon;
  final VoidCallback onPressed;
  final String svg;

  const ActionButton({
    Key? key,
    required this.text,
    this.isShowIcon = true,
    required this.onPressed,
    this.svg = 'assets/svgs/plus.svg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isShowIcon) ...[
                SvgPicture.asset(
                  svg,
                  color: colorBlue,
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: colorBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SetGoalText extends StatelessWidget {
  final VoidCallback onTap;

  const SetGoalText({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Set Goal',
            style: TextStyle(
              fontSize: 16,
              color: colorBlue,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
            
              height: 1,
            ),
            
          ),
          Container(
            height: 1,
            width: 55,
            color: colorBlue,
          ),
        ],
      ),
    );
  }
}

class CustomLabelWidget extends StatelessWidget {
  final String title;
  final bool isChangeColor;
  final bool isPadding;

  const CustomLabelWidget({
    Key? key,
    this.title = 'Today’s Mission',
    this.isChangeColor = false,
    this.isPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPadding ? 8 : 16),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isChangeColor ? colorBlue : colorDarkBlue,
              fontFamily: 'BoldCairo',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
