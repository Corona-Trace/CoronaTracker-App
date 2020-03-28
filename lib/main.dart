import 'dart:io';

import 'package:corona_trace/LocationUpdates.dart';
import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/notifications/NotificationsListScreen.dart';
import 'package:corona_trace/ui/screens/Onboarding.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/AppLocalization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiRepository.getIsOnboardingDone().then((onboardingDone) {
    ApiRepository.getUserSeverity().then((userSeverity) {
      var isOnboardinDone =
          onboardingDone == null ? false : onboardingDone as bool;
      var severity = userSeverity == null ? -1 : userSeverity as int;
      runApp(MyApp(isOnboardinDone, severity));
    });
  });
}

MaterialColor appColor = MaterialColor(
  Color.fromRGBO(44, 48, 84, 1.0).value,
  <int, Color>{
    50: Color.fromRGBO(44, 48, 84, .1),
    100: Color.fromRGBO(44, 48, 84, .2),
    200: Color.fromRGBO(44, 48, 84, .3),
    300: Color.fromRGBO(44, 48, 84, .4),
    400: Color.fromRGBO(44, 48, 84, .5),
    500: Color.fromRGBO(44, 48, 84, .6),
    600: Color.fromRGBO(44, 48, 84, .7),
    700: Color.fromRGBO(44, 48, 84, .8),
    800: Color.fromRGBO(44, 48, 84, .9),
    900: Color.fromRGBO(44, 48, 84, 1),
  },
);
final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool isOnboardinDone;
  final int severity;

  MyApp(this.isOnboardinDone, this.severity);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return getMaterialApp(this.isOnboardinDone, this.severity);
  }

  MediaQuery getMaterialApp(bool isOnboardinDone, int severity) {
    return MediaQuery(
      child: MaterialApp(
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('es'),
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          print(locale);
          if (locale == null) {
            debugPrint("*language locale is null!!!");
            return supportedLocales.first;
          }
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        title: 'CoronaTrace',
        navigatorKey: globalKey,
        theme: ThemeData(primarySwatch: appColor, fontFamily: 'Montserrat'),
        home: isOnboardinDone
            ? severity == -1
                ? UserInfoCollectorScreen()
                : NotificationsListScreen()
            : OnboardingScreen(),
      ),
      data: MediaQueryData(),
    );
  }
}
