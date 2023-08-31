import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Functions {
  static push(BuildContext context, Widget widget) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: widget,
    );
  }
}
