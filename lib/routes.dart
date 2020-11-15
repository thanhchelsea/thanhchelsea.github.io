import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/screens/FAQScreen.dart';
import 'package:flutter_earthquake_network/ui/screens/details.dart';
import 'package:flutter_earthquake_network/ui/screens/privacy_policy.dart';
import 'package:flutter_earthquake_network/ui/screens/screens.dart';
import 'package:flutter_earthquake_network/ui/screens/term_and_condition.dart';

class Routes {
  Routes._();
  //screen name
  static const String home = "/homeScreen";
  static const String searchScreen = "/searchScreen";
  static const String settingScreen = "/settings";
  static const String aboutscreen = "/about";
  static const String faqScreen = "/FAQScreen";
  static const String termAndCondition = "/term_and_conditionScreen";
  static const String privacyPolicy = "/aboutScreen";
  static const String mapSettings = "/mapSettingsScreen";
  static const String notificationSetting = "/notificationSettingScreen";
  static const String earthquakeDetais = "/details";
  static const String sosSettingsScreen = "/sosSettingsScreen";
  static const String sosSettingSMS = "/sosSettingSMS";

  static String initScreen() => home;
  //init screen name
  static final routes = <String, WidgetBuilder>{
    home: (context) => Home(),
    searchScreen: (context) => SearchScreen(),
    settingScreen: (context) => SettingScreens(),
    aboutscreen: (context) => AboutScreen(),
    faqScreen: (context) => FAQScreen(),
    termAndCondition: (context) => TermAndConditionScreen(),
    privacyPolicy: (context) => PrivacyPolicy(),
    mapSettings: (context) => MapSettingScreen(),
    notificationSetting: (context) => NotificationSettingScreen(),
    earthquakeDetais: (context) => Details(),
    sosSettingsScreen: (context) => SOSSetingsScreen(),
    sosSettingSMS: (context) => SMSSetting(),
  };
}
