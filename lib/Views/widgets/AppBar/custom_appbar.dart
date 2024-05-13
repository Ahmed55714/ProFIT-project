import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';

import '../../pages/Diet/Shop List/shoppin_list.dart';
import '../../pages/Explore/Favorites/favourites.dart';
import '../../pages/Explore/Package/package.dart';
import '../../pages/Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import '../../pages/Tabs/Explore/controller/trainer_controller.dart';
import '../Animation/AnimationPage.dart';
import '../BottomSheets/add_challenge.dart';
import '../Profile/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool showContainer;
  final bool isShowDropdown;
  final bool isShowChat;
  final bool isShowExplore;
  final bool isShowProfile;
  final bool isShowNormal;
  final String? dropdownValue;
  final bool isShowFavourite;
  final bool isShowActiveDiet;
  final bool isShowActiveWorkout;
  final PreferredSizeWidget? bottomWidget;
  final ValueChanged<String?>? onDropdownChanged;
  final VoidCallback? onBack;

   CustomAppBar({
    Key? key,
    required this.titleText,
    this.showContainer = false,
    this.isShowDropdown = false,
    this.isShowChat = false,
    this.isShowExplore = false,
    this.isShowProfile = false,
    this.isShowFavourite = false,
    this.isShowNormal = false,
    this.isShowActiveDiet = false,
    this.isShowActiveWorkout = false,
    this.bottomWidget,
    this.dropdownValue,
    this.onDropdownChanged,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: AppBar(
        toolbarHeight: 64,
        automaticallyImplyLeading: !isShowExplore && !isShowNormal,
        leading: _buildLeading(context),
        title: _buildTitle(context),
        actions: _buildActions(),
        bottom: bottomWidget,
        backgroundColor: _determineBackgroundColor(),
        elevation:
            isShowFavourite && isShowProfile ? 0 : (showContainer ? 0 : 0.5),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    final ExploreController exploreController = Get.put(ExploreController());

    if (isShowExplore || isShowNormal) {
      return null;
    }
    return showContainer
        ? IconButton(
            icon: SvgPicture.asset(
              'assets/svgs/whiteBack.svg',
            ),
            onPressed: () => Get.back(result: true))
        : isShowFavourite
            ? IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/lightBack.svg',
                ),
                onPressed: onBack ?? () {
                Get.back(result: true);
                 
                })
            : IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/Frame 52322.svg',
                ),
                onPressed: () => Get.back(result: true));
  }

  Widget _buildTitle(BuildContext context) {
    return isShowChat
        ? _buildChatTitle()
        : isShowExplore || isShowNormal
            ? _buildExploreTitle(context)
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
              children: [
                Row(
                  children: [
                    const Text(
                      'Ahmed Tarek',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'BoldCairo',
                      ),
                    ),
                  ],
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
                        fontSize: 15,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(16, 0),
            child: SvgPicture.asset('assets/svgs/menu-vertical.svg'),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          '${titleText}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontFamily: 'BoldCairo',
          ),
        ),
        const Spacer(),
        isShowActiveWorkout
            ? GestureDetector(
                onTap: () => _showSendAssessmentConfirmation(context),
                child: SvgPicture.asset('assets/svgs/more.svg'))
            : isShowActiveDiet && isShowNormal
                ? Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(_createRoute());
                          },
                          child: SvgPicture.asset('assets/svgs/cart.svg')),
                      SizedBox(width: 8),
                      GestureDetector(
                          onTap: () => _showSendAssessmentConfirmation(context),
                          child: SvgPicture.asset('assets/svgs/more.svg')),
                    ],
                  )
                : isShowExplore && !isShowNormal
                    ? GestureDetector(
                        onTap: () {
                            Navigator.of(context).push(createRoute(FavoritesScreen()));

                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset('assets/svgs/Favorite.svg'),
                        ),
                      )
                    : Container()
      ],
    );
  }

  Widget _buildDefaultTitle() {
    return Transform.translate(
      offset: const Offset(-16, 0),
      child: Column(
        children: [
          Text(
            titleText,
            style: TextStyle(
              color: showContainer ? Colors.white : colorBlue,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontFamily: 'BoldCairo',
            ),
          ),
        ],
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
          onPressed: () {},
        ),
      );
    }

    return actions.isEmpty ? null : actions;
  }

  Color _determineBackgroundColor() {
    return isShowExplore || isShowNormal || showContainer
        ? colorBlue
        : Colors.white;
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

void _showSendAssessmentConfirmation(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.35,
          ),
          child: Column(children: <Widget>[
            CustomHeaderWithCancel(
              title: 'More',
              onCancelPressed: () => Navigator.pop(context),
            ),
            SettingsTile(
                svgIcon: 'assets/svgs/applee.svg',
                title: 'Personal Data',
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/star-11.svg',
                title: 'Rate Diet',
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/info-circle.svg',
                title: 'Diet Information',
                onTap: () {}),
          ]),
        ),
      );
    },
  );
}

// Animated navigation

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ShoppingList(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 800),
  );
}
