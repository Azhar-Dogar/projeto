class AppIcons {
  static var main = "assets/icons/";
  static var user = getName("user.png");
  static var calendar = getName("calendar.png");
  static var home = getName("home.png");
  static var notification = getName("notification.png");
  static var chat = getName("chat.png");
  static var brief = getName("brief.png");
  static var dollar = getName("dollar.png");
  static var profile = getName("profile.png");
  static var trending = getName("trending.png");

  static String getName(String name) {
    return "$main$name";
  }
}
class AppImages{
  static var main = "assets/images/";
  static var profile = getName("profile.png");
  static var autoImage = getName("auto_image.png");
  static var clock = getName("Clock.png");
  static var demo = getName("demo.jpeg");
  static String getName(String name) {
    return "$main$name";
  }
}