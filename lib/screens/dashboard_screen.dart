import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/screens/dashboard/chat_screen.dart';
import 'package:projeto/screens/dashboard/classes_screen.dart';
import 'package:projeto/screens/dashboard/home_screen.dart';
import 'package:projeto/screens/dashboard/notification_screen.dart';
import 'package:projeto/screens/dashboard/profile_screen.dart';
import 'package:projeto/widgets/custom_asset_image.dart';

import '../extras/colors.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget> pages = [
    const ProfileScreen(),
    const ClassesScreen(),
    const HomeScreen(),
     NotificationScreen(),
     ChatScreen(),
  ];

  int selectedIndex = 2;

  late List<PersistentBottomNavBarItem> bottomNavBarItems ;

  late PersistentTabController _controller;


  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(
        initialIndex: 2); // Set the initial index to the "Home" screen
  }

  @override
  Widget build(BuildContext context) {

    bottomNavBarItems = [
      PersistentBottomNavBarItem(
        icon: CustomAssetImage(path: AppIcons.user, height: 24, color: selectedIndex == 0 ? Colors.white : CColors.textFieldBorder,),
        title: "Profile",
        activeColorPrimary:  CColors.primary,
        inactiveColorPrimary:  CColors.textFieldBorder,
      ),
      PersistentBottomNavBarItem(
        icon: CustomAssetImage(path: AppIcons.calendar, height: 24, color: selectedIndex == 1 ? Colors.white : CColors.textFieldBorder,),
        title: "Aulas",
        activeColorPrimary: CColors.primary,
        inactiveColorPrimary: CColors.textFieldBorder,
      ),
      PersistentBottomNavBarItem(
        icon: CustomAssetImage(path: AppIcons.home, height: 24, color: selectedIndex == 2 ? Colors.white : CColors.textFieldBorder,),
        title: "Home",
        activeColorPrimary: CColors.primary,
        inactiveColorPrimary: CColors.textFieldBorder,
      ),
      PersistentBottomNavBarItem(
        icon: CustomAssetImage(path: AppIcons.notification, height: 24, color: selectedIndex == 3 ? Colors.white : CColors.textFieldBorder,),
        title:  selectedIndex == 3 ?  "Notif..."  : "Notificação",
        activeColorPrimary: CColors.primary,
        inactiveColorPrimary: CColors.textFieldBorder,
      ),
      PersistentBottomNavBarItem(
        icon: CustomAssetImage(path: AppIcons.chat, height: 24, color: selectedIndex == 4 ? Colors.white : CColors.textFieldBorder,),
        title: "Chat",
        activeColorPrimary: CColors.primary,
        inactiveColorPrimary: CColors.textFieldBorder,
      ),
    ];

    return Scaffold(
      backgroundColor: CColors.dashboard,
      body: PersistentTabView.custom(
        context,
        controller: _controller,
        screens: pages,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        // decoration: NavBarDecoration(
        //   colorBehindNavBar: CColors.primary,
        //   borderRadius: BorderRadius.circular(16.0),
        // ),
        // popAllScreensOnTapOfSelectedTab: true,
        // popActionScreens: PopActionScreensType.all,
        // itemAnimationProperties: const ItemAnimationProperties(
        //   duration: Duration(milliseconds: 200),
        //   curve: Curves.easeInOut,
        // ),

        onWillPop: (context) async {
          return true;
        },

        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 200),
        ),
        customWidget: CustomNavBarWidget(
          bottomNavBarItems,
          selectedIndex: selectedIndex,
          onItemSelected: (int value) {
            setState(() {
              selectedIndex = value;
            });
            _controller.jumpToTab(value);
          },
        ),
        itemCount: 5,
        // navBarStyle: NavBarStyle.simple, // Choose the nav bar style with this property.
      ),
    );
  }
}

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget(
    this.items, {
    final Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  Widget _buildItem(
          final PersistentBottomNavBarItem item, final bool isSelected) =>
      Container(
        width: 70,
        alignment: Alignment.center,
        height: kBottomNavigationBarHeight,
        decoration: isSelected ? BoxDecoration(
          shape: BoxShape.circle,
          color: CColors.primary,
        ) : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconTheme(
              data: const IconThemeData(
                  size: 26,
                  color: Colors.amber),
              child: item.icon ,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                item.title!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : item.inactiveColorPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 12),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(final BuildContext context) => Container(
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((final item) {
              final int index = items.indexOf(item);
              return Flexible(
                child: GestureDetector(
                  onTap: () {
                    onItemSelected(index);
                  },
                  child: _buildItem(item, selectedIndex == index),
                ),
              );
            }).toList(),
          ),
        ),
      );
}

