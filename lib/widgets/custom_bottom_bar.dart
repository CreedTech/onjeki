// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:onjeki/core/utils/image_constant.dart';
import 'package:onjeki/theme/theme_helper.dart';
import 'package:onjeki/widgets/custom_image_view.dart';

enum BottomBarEnum {
  home,
  wishlist,
  inbox,
  history,
  profile,
}

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});

  Function(BottomBarEnum)? onChanged;
  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      label: 'Explore',
      icon: ImageConstant.home,
      activeIcon: ImageConstant.home,
      type: BottomBarEnum.home,
    ),
    BottomMenuModel(
      label: 'Wishlist',
      icon: ImageConstant.wishlist,
      activeIcon: ImageConstant.wishlist,
      type: BottomBarEnum.wishlist,
    ),
    BottomMenuModel(
      label: 'Inbox',
      icon: ImageConstant.inbox,
      activeIcon: ImageConstant.inbox,
      type: BottomBarEnum.inbox,
    ),
    BottomMenuModel(
      label: 'History',
      icon: ImageConstant.history,
      activeIcon: ImageConstant.history,
      type: BottomBarEnum.history,
    ),
    BottomMenuModel(
      label: 'Profile',
      icon: ImageConstant.profile,
      activeIcon: ImageConstant.profile,
      type: BottomBarEnum.profile,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(
          color: colorPrimary,
        ),
        unselectedLabelStyle: const TextStyle(
          color: textGray,
        ),
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              width: 24,
              height: 24,
              color: textGray,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              width: 24,
              height: 24,
              color: colorPrimary,
            ),
            label: bottomMenuList[index].label,
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.type,
  });
  String label;
  String icon;
  String activeIcon;
  BottomBarEnum type;
}
