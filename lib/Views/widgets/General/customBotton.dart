import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isShowIcon;
  final String? icon;
  final bool isShowSmall;
  final bool isShowDifferent;
  final bool Subscription;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isShowIcon = false,
    this.icon,
    this.isShowSmall = false,
    this.isShowDifferent = false,
    this.Subscription = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: _getButtonBackgroundColor(),
          onPrimary: _getTextColor(), // Text color
          minimumSize: Size(isShowSmall ? 111 : double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isShowDifferent
                ? BorderSide(color: colorBlue)
                : BorderSide.none,
          ),
        ),
        child: _buildButtonChild(),
      ),
    );
  }

  Widget _buildButtonChild() {
    return isShowIcon && icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, style: _getTextStyle()),
              const SizedBox(width: 10),
              SvgPicture.asset(icon!),
            ],
          )
        : Text(text, style: _getTextStyle());
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: 18,
      height: 1.26,
      fontFamily: 'BoldCairo',
      color: _getTextColor(),
    );
  }

  Color _getButtonBackgroundColor() {
    if (isShowDifferent) return Colors.white;
    return Subscription ? red100 : (isShowIcon ? backgroundBlue : colorBlue);
  }

  Color _getTextColor() {
    return Subscription ? red600 : (isShowDifferent ? colorBlue : Colors.white);
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
              fontSize: 19,
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
// class CustomLabelWidget extends StatelessWidget {
//   final String title;
//   final bool isChangeColor;
//   final bool isPadding;

//   const CustomLabelWidget({
//     Key? key,
//     this.title = 'Today’s Mission',
//     this.isChangeColor = false,
//     this.isPadding = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: isPadding ? 8 : 16),
//       child: Row(
//         children: [
//           Flexible( 
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 19,
//                 fontWeight: FontWeight.w700,
//                 color: isChangeColor ? colorBlue : colorDarkBlue,
//                 fontFamily: 'BoldCairo',
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
