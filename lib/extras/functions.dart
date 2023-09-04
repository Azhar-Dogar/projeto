import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:utility_extensions/utility_extensions.dart';
class Functions {
  static push(BuildContext context, Widget widget) {
    // PersistentNavBarNavigator.pushNewScreen(
    //   context,
    //   screen: widget,
    // );

    context.push(child: widget);
  }

  static pushAndRemoveUntil(BuildContext context, Widget widget) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: widget,
    );
  }
}
