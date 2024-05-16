import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class MyInputTextField extends StatefulWidget {
  final String? title;
  final String? helperText;
  final bool isSecure;
  final int maxLength;
  final String? hint;
  final TextInputType? inputType;
  final String? initValue;
  final Color? backColor;
  final Widget? suffix;
  final Widget? prefix;
  final FocusNode focusNode;
  final TextEditingController? textEditingController;
  final String? Function(String? value)? validator;
  final String? errorText;
  final Function(String)? onChanged;
  final Function(String)? onSaved;
  List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onFieldSubmitted;
  final bool shouldValidate;
  final bool isShowChange;
  static const int MAX_LENGTH = 500;
  final bool isdropMenu;
  

  MyInputTextField({
    super.key,
    this.title,
    this.hint,
    this.helperText,
    this.inputType,
    this.initValue = "",
    this.isSecure = false,
    this.textEditingController,
    this.validator,
    this.errorText,
    this.maxLength = MAX_LENGTH,
    this.onChanged,
    this.onSaved,
    this.inputFormatters,
    this.backColor,
    this.suffix,
    this.prefix,
    this.onFieldSubmitted,
    required this.focusNode,
    this.shouldValidate = true,
    this.isShowChange = false,
    this.isdropMenu = false,
    required bool autoCorrect,
  });

  @override
  _MyInputTextFieldState createState() => _MyInputTextFieldState();
}

class _MyInputTextFieldState extends State<MyInputTextField> {
  late bool _passwordVisibility;
  late ThemeData theme;

  Color _borderColor = grey200;
  double _borderSize = 1;

  @override
  void initState() {
    super.initState();
    _passwordVisibility = !widget.isSecure;
    widget.textEditingController?.text = widget.initValue ?? "";

    widget.focusNode.addListener(() {
      setState(() {
        _borderSize = widget.focusNode.hasFocus ? 1.7 : 1;
      });
    });
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.focusNode.hasFocus
            ? Container(
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: _borderColor, width: _borderSize),
                  borderRadius: BorderRadius.circular(12),
                ),
              )
            : _borderColor == grey200
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: _borderColor, width: _borderSize),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                : AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 56,
                    decoration: BoxDecoration(
                      color: grey50,
                      border: Border.all(color: grey200, width: _borderSize),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            autocorrect: false,
            onFieldSubmitted: widget.onFieldSubmitted,
            obscureText: !_passwordVisibility,
            keyboardType: widget.inputType,
            cursorColor: Colors.white,
            validator: (value) {
              if (value!.isEmpty) {
                String? f = widget.validator?.call(value);
                setState(() {
                  _borderColor = f != null ? Colors.red : grey200;
                });
                return f;
              }
            },
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: DArkBlue900,
              fontSize: 13,
              height: 1.1,
              letterSpacing: 0.5,
            ),
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            maxLines: 1,
            onChanged: (text) {
              widget.onChanged?.call(text);
            },
            decoration: InputDecoration(
              counterText: "",
              hintStyle: theme.textTheme.titleMedium,
              floatingLabelStyle: const TextStyle(
                  color: profileGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              labelText: widget.title,
              helperText: widget.helperText,
              suffixIcon: !widget.isShowChange
                  ? getSuffixIcon()
                  : widget.isdropMenu
                      ? buildDropdownButton()
                      : const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              Text(
                                'change',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: colorBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
              prefixIcon: widget.prefix,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              errorText: widget.errorText,
            ),
          ),
        )
      ],
    );
  }

  Widget buildDropdownButton() {
    return PopupMenuButton<String>(
      icon: SvgPicture.asset(
        'assets/svgs/chevron-small-leftt.svg',
        width: 100,
        height: 100,
      ),
      onSelected: (String value) {
        widget.textEditingController?.text = value;
        widget.onSaved?.call(value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Option 1',
          child: Text('Option 1'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 2',
          child: Text('Option 2'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 3',
          child: Text('Option 3'),
        ),
        
      ],
      elevation: 0.8,
    );
    
  }

  Widget? getSuffixIcon() {
    return widget.isSecure ? getPasswordSuffixIcon() : widget.suffix;
  }

  Widget? getPasswordSuffixIcon() {
    return IconButton(
      hoverColor: Colors.transparent,
      focusColor: profileGrey,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: _passwordVisibility
          ? SvgPicture.asset(
              'assets/images/Eye.svg',
              color: profileGrey,
            )
          : const Icon(Icons.visibility_off_outlined,
              color: profileGrey, size: 20),
      onPressed: () {
        setState(() {
          _passwordVisibility = !_passwordVisibility;
        });
      },
    );
  }
}
