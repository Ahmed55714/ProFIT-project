import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const ProfileSection({
    Key? key,
    required this.title,
    required this.tiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: DArkBlue900,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: grey200),
             
              ),
              child: Column(
                children: tiles,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatefulWidget {
  final String title;
  final Widget? subtitle;
  final VoidCallback onTap;
  final String svgIcon;
  final Color backgroundColor;
  final Color text;
  final bool isShowIcon;
  final bool isShowLogOut;
  final bool switchValue;

  final ValueChanged<bool>? onSwitchValueChanged;

  const SettingsTile({
    Key? key,
    required this.title,
    this.text = DArkBlue900,
    this.subtitle,
    required this.onTap,
    required this.svgIcon,
    this.backgroundColor = Colors.white,
    this.isShowIcon = false,
    this.switchValue = false,
    this.isShowLogOut = false,
    this.onSwitchValueChanged,
  }) : super(key: key);

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.switchValue;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0), // Only round the corners
      child: Container(
        color: widget.backgroundColor,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Visibility(
                        visible: !widget.isShowIcon,
                        child: SvgPicture.asset(
                          widget.svgIcon,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: widget.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.isShowIcon && widget.isShowLogOut) ...[
                CupertinoSwitch(
                  activeColor: blue700,
                  trackColor: grey200,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                    if (widget.onSwitchValueChanged != null) {
                      widget.onSwitchValueChanged!(value);
                    }
                  },
                ),
              ],
              if (widget.subtitle != null) ...[
                widget.subtitle!,
              ],
              if (!widget.isShowIcon && !widget.isShowLogOut)
                SvgPicture.asset(
                  'assets/svgs/chevron-small-right.svg',
                ),
            ],
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
