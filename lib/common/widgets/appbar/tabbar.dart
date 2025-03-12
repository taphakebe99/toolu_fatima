import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MyHelperFunctions.isDarkMode(context);

    return Material(
      color: isDarkMode ? MyColors.black : MyColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: MyColors.primary,
        unselectedLabelColor: MyColors.darkerGrey,
        labelColor: isDarkMode ? MyColors.white : MyColors.primary,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MyDeviceUtility.getAppBarHeight());
}
