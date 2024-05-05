import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/utils/colors.dart';

import 'customBotton.dart';

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
  final bool isShowSearch;
  final bool isShowColor;
  final bool isShowButton;
  final bool isShowInside;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

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
    this.isShowButton = false,
    this.isShowInside = false,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
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
    if (_controller.text.length > 200) {
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
              color: widget.isShowColor ? Colors.white : grey50,
              child: TextFormField(
                controller: _controller,
                focusNode: widget.focusNode,
                textInputAction: widget.textInputAction,
                onFieldSubmitted: widget.onFieldSubmitted,
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
                            borderSide: const BorderSide(color: grey200),
                          )
                        : const UnderlineInputBorder(
                            borderSide: BorderSide(color: grey50),
                          ),
                    focusedBorder: widget.showBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: grey200),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                    prefixIcon: widget.isShowSearch
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
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
                        : widget.isShowButton
                            ? ActionButton(
                                text: 'Apply',
                                onPressed: () {},
                              )
                            : widget.isShowInside
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          'change',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: colorBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : null),
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







// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:profit1/utils/colors.dart';

// class CustomTextField extends StatefulWidget {
//   final String labelText;
//   final TextEditingController? controller;
//   final double fieldHeight;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;
//   final bool showClearIcon;
//   final bool showCharacterCount;
//   final int? maxLines;
//   final void Function(String)? onChange;
//   final bool isPasswordField;
//   final bool showBorder;
//   final String? name;
//   final Widget? prefixIcon;
//   final bool isShowSearch;
//   final bool isShowColor;

//   const CustomTextField({
//     Key? key,
//     required this.labelText,
//     this.fieldHeight = 56.0,
//     this.controller,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//     this.showClearIcon = false,
//     this.showCharacterCount = false,
//     this.maxLines,
//     this.onChange,
//     this.isPasswordField = false,
//     this.showBorder = true,
//     this.name = '',
//     this.prefixIcon,
//     this.isShowSearch = false,
//     this.isShowColor = false,
//   }) : super(key: key);

//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   late TextEditingController _controller;
//   bool _isPasswordVisible = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller ?? TextEditingController();
//     _isPasswordVisible = !widget.isPasswordField;
//   }

//   @override
//   void dispose() {
//     if (widget.controller == null) {
//       _controller.dispose();
//     }
//     super.dispose();
//   }

//   void _validateInput(String? value) {
//     String? validationResponse = widget.validator?.call(value);
//     setState(() {
//       _errorMessage = validationResponse;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 17.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildLabel(),
//           const SizedBox(height: 4),
//           _buildTextField(),
//           _buildErrorMessage(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLabel() {
//     if (widget.isShowSearch || widget.name == null) {
//       return SizedBox.shrink();
//     }
//     return Text(
//       widget.name!,
//       style: const TextStyle(
//           fontSize: 13, fontWeight: FontWeight.w400, color: colorDarkBlue),
//     );
//   }

//   Widget _buildTextField() {
//     return ConstrainedBox(
//       constraints: BoxConstraints(minHeight: widget.fieldHeight),
//       child: Container(
//         color: widget.isShowColor ? Colors.white : grey50,
//         child: TextFormField(
//           controller: _controller,
//           keyboardType: widget.keyboardType,
//           maxLines: widget.maxLines ?? 1,
//           obscureText: widget.isPasswordField && !_isPasswordVisible,
//           decoration: _buildInputDecoration(),
//           onChanged: (value) {
//             if (widget.onChange != null) {
//               widget
//                   .onChange!(value); // Call the original onChange if provided.
//             }
//             _validateInput(
//                 value); // Additional custom logic to set _errorMessage based on the same validation.
//           },
//           validator: (value) {
//             final result = widget.validator?.call(value);
//             if (result != null) {
//               setState(() {
//                 _errorMessage = result;
//               });
//             }
//             return result;
//           },
//         ),
//       ),
//     );
//   }

//   InputDecoration _buildInputDecoration() {
//     return InputDecoration(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 14),
//       labelText: widget.labelText,
//       labelStyle: const TextStyle(
//           fontSize: 13, fontWeight: FontWeight.w400, color: grey500),
//       errorStyle: const TextStyle(height: 0.01, color: Colors.transparent),
//       floatingLabelBehavior: FloatingLabelBehavior.never,
//       border: widget.showBorder ? _borderStyle() : InputBorder.none,
//       enabledBorder: widget.showBorder ? _borderStyle() : InputBorder.none,
//       focusedBorder:
//           widget.showBorder ? _borderStyle(focused: true) : InputBorder.none,
//       prefixIcon: widget.isShowSearch
//           ? Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: SvgPicture.asset('assets/svgs/searchh.svg'))
//           : widget.prefixIcon,
//       suffixIcon: _buildSuffixIcon(),
//     );
//   }

//   OutlineInputBorder _borderStyle({bool focused = false}) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//       borderSide: BorderSide(
//           color: focused ? Theme.of(context).colorScheme.primary : grey200),
//     );
//   }

//   Widget? _buildSuffixIcon() {
//     if (widget.showClearIcon &&
//         _controller.text.isNotEmpty &&
//         !widget.isPasswordField) {
//       return GestureDetector(
//           onTap: _controller.clear,
//           child: const Icon(Icons.clear, color: grey300));
//     } else if (widget.isPasswordField) {
//       return GestureDetector(
//         onTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
//         child: Icon(
//             _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//             color: grey300),
//       );
//     }
//     return null;
//   }

//   Widget _buildErrorMessage() {
//     if (_errorMessage != null) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 8.0, left: 10, bottom: 8),
//         child: Row(
//           children: [
//             Image.asset('assets/images/alert.png', width: 20),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 _errorMessage ?? '',
//                 style: const TextStyle(
//                   color: Colors.red,
//                   fontSize: 13,
//                   fontFamily: 'Arial',
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     return SizedBox
//         .shrink();
//   }
// }
