import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  late String labelText;
  late TextEditingController? controller;
  late double fieldHeight;
  late TextInputType keyboardType;
  late String? Function(String?)? validator;
  late bool showClearIcon;
  late bool showCharacterCount;
  late int? maxLines;
  late void Function(String)? onChange;
  late bool isPasswordField;
  late bool showBorder;
  late String? name;
  late Widget? prefixIcon;
  late bool isShowSearch;
  late bool isShowColor;

  CustomTextField({
    Key? key,
    required this.labelText,
    this.fieldHeight = 56.0,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.showClearIcon = false,
    this.showCharacterCount = false,
    this.maxLines,
    this.onChange,
    this.isPasswordField = false,
    this.showBorder = true,
    this.name = '',
    this.prefixIcon,
    this.isShowSearch = false,
    this.isShowColor = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  String? _errorMessage;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChange);
    _isPasswordVisible = !widget.isPasswordField;
  }

  void _handleTextChange() {
    if (_controller.text.length > 24) {
      _controller.text = _controller.text.substring(0, 24);
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.isShowSearch)
            Text(
              '${widget.name}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: colorDarkBlue,
              ),
            ),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight:
                    widget.fieldHeight + (widget.validator != null ? 0 : 0)),
            child: Container(
              color: widget.isShowColor?Colors.white :  grey50,
              child: TextFormField(
                controller: _controller,
                keyboardType: widget.keyboardType,
                maxLines: 1,
                obscureText: !widget.isPasswordField ||
                        !_isPasswordVisible ||
                        _controller.text.isEmpty
                    ? false
                    : true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 11, right: 3, top: 14, bottom: 14),
                  labelText: widget.labelText,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: grey500,
                  ),
                  errorStyle:
                      const TextStyle(height: 0.3, color: Colors.transparent),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: widget.showBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )
                      : null,
                  enabledBorder: widget.showBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: grey200),
                        )
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: grey50),
                        ),
                  focusedBorder: widget.showBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: grey200),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                  prefixIcon: widget.isShowSearch
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/svgs/searchh.svg'),
                        )
                      : widget.prefixIcon,
                  suffixIcon: widget.showClearIcon &&
                          !widget.showCharacterCount &&
                          !widget.isPasswordField &&
                          _controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _controller.clear();
                          },
                          child: Image.asset(
                            'assets/images/magnifier.png',
                            width: 24,
                            height: 24,
                          ),
                        )
                      : widget.isPasswordField
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Image.asset(
                                _isPasswordVisible
                                    ? 'assets/images/see.png'
                                    : 'assets/images/dontsee.png',
                                width: 24,
                                height: 24,
                                color: grey300,
                              ),
                            )
                          : null,
                  suffix: widget.showCharacterCount
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Text(
                                '${_controller.text.length}/24',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
                onChanged: !widget.showClearIcon &&
                        !widget.showCharacterCount &&
                        !widget.isPasswordField
                    ? widget.onChange
                    : (value) {
                        if (_errorMessage != null) {
                          setState(() {
                            _errorMessage = null;
                          });
                        }
                        widget.onChange?.call(value);
                      },
                validator: (value) {
                  final result = widget.validator?.call(value);
                  if (result != null) {
                    setState(() {
                      _errorMessage = result;
                    });
                  }
                  return result;
                },
              ),
            ),
          ),
          if (_errorMessage != null) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                left: 10,
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/alert.png', width: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
