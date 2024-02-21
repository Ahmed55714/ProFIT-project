import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final double fieldHeight;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool showClearIcon;
  final bool showCharacterCount;
  final int? maxLines;
  final void Function(String)? onChange;
  final bool isPasswordField;
  final bool showBorder;
  final String? name;
  final Widget? prefixIcon;

  const CustomTextField({
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
    this.name,
    this.prefixIcon,
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
            constraints: BoxConstraints(minHeight: widget.fieldHeight + (widget.validator != null ?0 : 0)), 
            child: Container(
              color: grey50,
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
                       contentPadding: const EdgeInsets.only(left: 11, right: 3, top: 14, bottom: 14
                      ),
                      
                  labelText: widget.labelText,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
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
                              color: Color.fromRGBO(209, 213, 219, 1)),
                        )
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: grey50),
                        ),
                  focusedBorder: widget.showBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(209, 213, 219, 1)),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                  prefixIcon: widget.prefixIcon,
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
            padding: const EdgeInsets.only(top: 0.0, left: 10,),
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
