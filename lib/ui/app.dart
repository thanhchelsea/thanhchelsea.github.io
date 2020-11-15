import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/utils/navigator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../constants.dart';
import '../localizations.dart';
import '../routes.dart';


class MyApp extends StatelessWidget {

  final String language;
  MyApp.language({this.language});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      localizationsDelegates: [
        const LanguageDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      locale: this.language == null
          ? Constants.SUPPORT_LOCALE[0]
          : Locale(this.language),
      supportedLocales: Constants.SUPPORT_LOCALE,
      localeResolutionCallback: (locale, supportedLocales) =>
          _localeCallback(locale, supportedLocales),
      initialRoute: Routes.initScreen(),
      routes: Routes.routes,
    );
  }

  Locale _localeCallback(Locale locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    // If the locale of the device is not supported, use the first one
    // from the list (japanese, in this case).
    return supportedLocales.first;
  }

  MyApp({this.language});
}
