import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/instructor/dashboard/instructor_home.dart';
import 'package:projeto/screens/instructor/dashboard/instructor_profile_screen.dart';
import 'package:projeto/screens/instructor/dashboard/schedule.dart';
import 'package:provider/provider.dart';
import '../../extras/app_assets.dart';
import '../../extras/colors.dart';
import '../../extras/constants.dart';
import '../../model/notification_model.dart';
import '../../provider/dashboard_provider.dart';
import '../../provider/data_provider.dart';
import '../../widgets/custom_asset_image.dart';
import '../dashboard/chat_screen.dart';
import '../dashboard/notification_screen.dart';
import '../dashboard_screen.dart';

class InstructorDashboard extends StatefulWidget {
  const InstructorDashboard({super.key});

  @override
  State<InstructorDashboard> createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {
  late DashboardProvider dashboardProvider;

  List<Widget> pages = [
    const InstructorProfileScreen(),
    const Schedule(),
    const InstructorHome(),
    NotificationScreen(
      isInstructor: true,
    ),
    ChatScreen(
      isInstructor: true,
    ),
  ];

  // int selectedIndex = 2;

  late List<PersistentBottomNavBarItem> bottomNavBarItems;

  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    dashboardProvider = context.read<DashboardProvider>();

    _controller = PersistentTabController(
        initialIndex: 2); // Set the initial index to the "Home" screen
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, value, child) {
      dashboardProvider = value;
      _controller.jumpToTab(dashboardProvider.selectedIndex);
      bottomNavBarItems = [
        PersistentBottomNavBarItem(
          icon: CustomAssetImage(
            path: AppIcons.user,
            height: 24,
            color: dashboardProvider.selectedIndex == 0
                ? Colors.white
                : CColors.textFieldBorder,
          ),
          title: "Profile",
          activeColorPrimary: CColors.primary,
          inactiveColorPrimary: CColors.textFieldBorder,
        ),
        PersistentBottomNavBarItem(
          icon: CustomAssetImage(
            path: AppIcons.calendar,
            height: 24,
            color: dashboardProvider.selectedIndex == 1
                ? Colors.white
                : CColors.textFieldBorder,
          ),
          title: "Aulas",
          activeColorPrimary: CColors.primary,
          inactiveColorPrimary: CColors.textFieldBorder,
        ),
        PersistentBottomNavBarItem(
          icon: CustomAssetImage(
            path: AppIcons.home,
            height: 24,
            color: dashboardProvider.selectedIndex == 2
                ? Colors.white
                : CColors.textFieldBorder,
          ),
          title: "Home",
          activeColorPrimary: CColors.primary,
          inactiveColorPrimary: CColors.textFieldBorder,
        ),
        PersistentBottomNavBarItem(
          icon: CustomAssetImage(
            path: AppIcons.notification,
            height: 24,
            color: dashboardProvider.selectedIndex == 3
                ? Colors.white
                : CColors.textFieldBorder,
          ),
          title:
              dashboardProvider.selectedIndex == 3 ? "Notif..." : "Notificação",
          activeColorPrimary: CColors.primary,
          inactiveColorPrimary: CColors.textFieldBorder,
        ),
        PersistentBottomNavBarItem(
          icon: CustomAssetImage(
            path: AppIcons.chat,
            height: 24,
            color: dashboardProvider.selectedIndex == 4
                ? Colors.white
                : CColors.textFieldBorder,
          ),
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
            selectedIndex: dashboardProvider.selectedIndex,
            onItemSelected: (int value) {
              dashboardProvider.selectedIndex = value;
              _controller.jumpToTab(dashboardProvider.selectedIndex);
              setState(() {});


              if (dashboardProvider.selectedIndex == 3) {

                Functions.readNotifications(context);

              }

            },
          ),
          itemCount: 5,
        ),
      );
    });
  }
}
