import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projeto/screens/instructor/dashboard/instructor_home.dart';
import 'package:projeto/screens/instructor/dashboard/schedule.dart';

import '../../extras/app_assets.dart';
import '../../extras/colors.dart';
import '../../widgets/custom_asset_image.dart';
import '../dashboard/chat_screen.dart';
import '../dashboard/classes_screen.dart';
import '../dashboard/home_screen.dart';
import '../dashboard/notification_screen.dart';
import '../dashboard/profile_screen.dart';
import '../dashboard_screen.dart';

class InstructorDashboard extends StatefulWidget {
  const InstructorDashboard({super.key});

  @override
  State<InstructorDashboard> createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {

  List<Widget> pages = [
    const ProfileScreen(),
    const Schedule(),
    const InstructorHome(),
    const NotificationScreen(),
     ChatScreen(isInstructor: true,),
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
