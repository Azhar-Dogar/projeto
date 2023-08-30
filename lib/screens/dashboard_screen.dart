import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/screens/dashboard/chat_screen.dart';
import 'package:projeto/screens/dashboard/classes_screen.dart';
import 'package:projeto/screens/dashboard/home_screen.dart';
import 'package:projeto/screens/dashboard/notification_screen.dart';
import 'package:projeto/screens/dashboard/profile_screen.dart';
import 'package:projeto/widgets/custom_text.dart';

import '../extras/colors.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CColors.dashboard,
        bottomNavigationBar: bottomNavigationBar(),
        body: pages[selectedIndex]);
  }

  List<Widget> pages = [
    const ProfileScreen(),
    const ClassesScreen(),
    const HomeScreen(),
    const NotificationScreen(),
    const ChatScreen()
  ];
  List<NavigationClass> bottomItems = [
    NavigationClass(label: "Profile", imagePath: AppIcons.user),
    NavigationClass(label: "Classes", imagePath: AppIcons.calendar),
    NavigationClass(label: "Home", imagePath: AppIcons.home),
    NavigationClass(label: "Notification", imagePath: AppIcons.notification),
    NavigationClass(label: "Chat", imagePath: AppIcons.chat),
  ];
  BottomNavigationBarItem bottomNavigationItem(
      String label, String imagePath, int index) {
    return BottomNavigationBarItem(
      backgroundColor: CColors.white,
      icon: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  (selectedIndex == index) ? CColors.primary : CColors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage(imagePath),
                  color: (selectedIndex == index)
                      ? CColors.white
                      : CColors.textFieldBorder,
                  width: 25,
                ),
                CustomText(
                  text: label,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textColor: (selectedIndex == index)
                      ? CColors.white
                      : CColors.textFieldBorder,
                )
              ],
            ),
          )),
      label: label,
    );
  }

  Widget bottomNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: CColors.textFieldBorder,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedFontSize: 14,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          elevation: 3,
          items: [
            for (var e = 0; e < bottomItems.length; e++)
              bottomNavigationItem(
                  bottomItems[e].label, bottomItems[e].imagePath, e)
          ]),
    );
  }
}

class NavigationClass {
  NavigationClass({required this.label, required this.imagePath});
  String imagePath;
  String label;
}
