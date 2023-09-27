import 'package:flutter/material.dart';

import '../screens/dashboard/chat_screen.dart';
import '../screens/dashboard/home_screen.dart';
import '../screens/dashboard/notification_screen.dart';
import '../screens/dashboard/profile_screen.dart';
import '../screens/dashboard/user_classes_screen.dart';

class DashboardProvider with ChangeNotifier {

  int _selectedIndex = 2;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  List<Widget> pages = [
    const ProfileScreen(),
    const UserClassesScreen(),
    const HomeScreen(),
    NotificationScreen(),
    ChatScreen(),
  ];
}
