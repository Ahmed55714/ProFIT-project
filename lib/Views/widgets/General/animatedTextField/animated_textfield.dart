import 'package:flutter/material.dart';
import 'custom_animate_border.dart';
import 'package:profit1/utils/colors.dart';

class AnimatedTextField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final Widget? suffix;
  final TextEditingController? controller;
  final List<String>? dropdownItems;
  final void Function(List<String>)? onChanged;
  final int? index;
  final bool? isDropdownOpen;
  final VoidCallback? onDropdownToggle;
  final bool singleSelection;
  final bool isShowCalendar; // new parameter

  AnimatedTextField({
    Key? key,
    required this.label,
    this.initialValue,
    this.suffix,
    this.controller,
    this.dropdownItems,
    this.onChanged,
    this.index,
    this.isDropdownOpen,
    this.onDropdownToggle,
    this.singleSelection = false,
    this.isShowCalendar = false, // default value is false
  }) : super(key: key);

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> alpha;
  final focusNode = FocusNode();
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    final Animation<double> curve = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
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

    if (widget.controller != null && widget.initialValue != null) {
      widget.controller!.text = widget.initialValue!;
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDropdownOpen != oldWidget.isDropdownOpen) {
      if (widget.isDropdownOpen == true) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    }
  }

  void _handleSuffixTap() {
    widget.onDropdownToggle?.call();
  }

  void _handleItemTap(String item) {
    setState(() {
      if (widget.singleSelection) {
        selectedItems = [item];
      } else {
        if (selectedItems.contains(item)) {
          selectedItems.remove(item);
        } else {
          selectedItems.add(item);
        }
      }
    });

    widget.controller?.text = selectedItems.join(' . ');
    if (widget.onChanged != null) {
      widget.onChanged!(selectedItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDropdownOpen = widget.isDropdownOpen ?? false;
    VoidCallback onDropdownToggle = widget.onDropdownToggle ?? () {};

    return Column(
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: grey200),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: colorBlue,
                  ),
            ),
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
                readOnly: widget.isShowCalendar || widget.dropdownItems != null,
                decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle: TextStyle(
                    color: alpha.value == 1 ? colorBlue : grey500,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Cairo',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: widget.isShowCalendar
                      ? GestureDetector(
                          onTap: widget.onDropdownToggle,
                          child: widget.suffix,
                        )
                      : widget.dropdownItems != null
                          ? GestureDetector(
                              onTap: _handleSuffixTap,
                              child: widget.suffix,
                            )
                          : null,
                ),
                onTap: () {
                  if (widget.isShowCalendar) {
                    _handleSuffixTap();
                  } else if (widget.dropdownItems != null) {
                    _handleSuffixTap();
                  }
                },
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ConstrainedBox(
            constraints: isDropdownOpen
                ? BoxConstraints(
                    maxHeight: 200,
                  )
                : BoxConstraints(
                    maxHeight: 0,
                  ),
            child: AnimatedOpacity(
              opacity: isDropdownOpen ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: grey200),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: widget.dropdownItems != null
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemCount: widget.dropdownItems!.length,
                        itemBuilder: (context, index) {
                          final item = widget.dropdownItems![index];
                          final isSelected = selectedItems.contains(item);
                          return ListTile(
                            title: Text(item),
                            trailing: isSelected
                                ? Icon(Icons.check, color: colorBlue)
                                : null,
                            onTap: () {
                              _handleItemTap(item);
                              onDropdownToggle(); // Close the dropdown
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Divider(
                              color: grey200,
                              height: 1,
                              thickness: 1,
                            ),
                          );
                        },
                      )
                    : SizedBox.shrink(),
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
