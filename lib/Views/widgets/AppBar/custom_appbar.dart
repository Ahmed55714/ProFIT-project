import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool showContainer;
  final bool isShowDropdown;
  final bool isShowChat;
  final bool isShowExplore;
  final bool isShowProfile;
  final String? dropdownValue;
  final ValueChanged<String?>? onDropdownChanged;

  const CustomAppBar({
    Key? key,
    required this.titleText,
    this.showContainer = false,
    this.isShowDropdown = false,
    this.isShowChat = false,
    this.isShowExplore = false,
    this.isShowProfile = false,
    this.dropdownValue,
    this.onDropdownChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: !isShowExplore,
      leading: _buildLeading(context),
      title: _buildTitle(),
      actions: _buildActions(),
      backgroundColor: _determineBackgroundColor(),
      elevation: showContainer ? 0 : 0.5,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (isShowExplore) {
      return null;
    }
    return showContainer
        ? IconButton(
            icon: SvgPicture.asset(
              'assets/svgs/whiteBack.svg',
            ),
            onPressed: () => Navigator.pop(context),
          )
        :null;
  }

  Widget _buildTitle() {
    return isShowChat
        ? _buildChatTitle()
        : isShowExplore
            ? _buildExploreTitle()
            : _buildDefaultTitle();
  }

  Widget _buildChatTitle() {
    return Transform.translate(
      offset: const Offset(-8, 0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/trainerr.png'),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Ahmed Tarek',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'BoldCairo',
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Online',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Transform.translate(
            offset: const Offset(16, 0),
            child: SvgPicture.asset('assets/svgs/menu-vertical.svg'),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreTitle() {
    return Row(
      children: [
        Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset('assets/svgs/Favorite.svg'),
        ),
      ],
    );
  }

  Widget _buildDefaultTitle() {
    return Transform.translate(
      offset: const Offset(-16, 0),
      child: Text(
        titleText,
        style: TextStyle(
          color: showContainer ? Colors.white : colorBlue,
          fontSize: 23,
          fontWeight: FontWeight.w700,
          fontFamily: 'BoldCairo',
        ),
      ),
    );
  }

List<Widget>? _buildActions() {
  List<Widget> actions = [];

  if (isShowDropdown) {
    // Add dropdown action
    actions.add(
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 120,
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorBlue),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: SvgPicture.asset(
                'assets/svgs/Chevron-Left.svg',
                color: colorBlue,
              ),
              iconSize: 24,
              elevation: 1,
              style: const TextStyle(
                color: colorBlue,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              onChanged: onDropdownChanged,
              items: <String>['Last 7 Days', 'Last 30 Days', 'All Time']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  if (isShowProfile) {
    // Add share action
    actions.add(
      IconButton(
        icon: SvgPicture.asset(
          'assets/svgs/share.svg',
        ),
        onPressed: () {
      
        },
      ),
    );
  }

  return actions.isEmpty ? null : actions;
}


  Color _determineBackgroundColor() {
    return isShowExplore || showContainer ? colorBlue : Colors.white;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
