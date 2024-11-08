import 'package:flutter/material.dart';
import 'package:raqeem/core/views/screens/chatbotScreen.dart';
import 'package:raqeem/core/views/screens/detelsScreen.dart';
import 'package:raqeem/core/views/screens/homeScreen.dart';
import 'package:raqeem/core/views/screens/laibryScreen.dart';
import 'package:raqeem/core/views/screens/login/LoginScreen.dart';
import 'package:raqeem/core/views/screens/login/virviScreen.dart';
import 'package:raqeem/core/views/screens/onbordScreen.dart';
import 'package:raqeem/core/views/screens/searchScreen.dart';
import 'package:raqeem/core/views/screens/splashScreen.dart';
import 'package:raqeem/core/views/screens/userDetelsScreen.dart';
import 'package:raqeem/core/views/screens/userScreen.dart';

class AppRoutes {
  //  تسوي هاندل لكل الملفات اعامل كل صفحة على اساس انها رابط
  static const String splashScreen = "/";
  static const String homescreen = "/home";
  static const String chatscreen = "/chat";
  static const String DetailsScreen = "/detls";
  static const String ExplorScreen = "/serach";
  static const String onbordScreen = "/onb";
  static const String logScreen = "/log";
  static const String virscreen = "/vir";
  static const String LibraryScren = "/lib";
  static const String AccountyScren = "/acu";
  static const String UserPrScren = "/upr";

  static Route<dynamic> generteRouts(RouteSettings Rsettings) {
    switch (Rsettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case "/home":
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case "/chat":
        return MaterialPageRoute(
          builder: (context) => ChatbotScreen(),
        );
      case "/detls":
        return MaterialPageRoute(
          builder: (context) => DetailsPage(),
        );
      case "/serach":
        return MaterialPageRoute(
          builder: (context) => ExploreScreen(),
        );
      case "/onb":
        return MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        );
      case "/log":
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );

      case "/vir":
        return MaterialPageRoute(
          builder: (context) => VirvafyScreen(),
        );
      case "/lib":
        return MaterialPageRoute(
          builder: (context) => LibraryScreen(),
        );
      case "/acu":
        return MaterialPageRoute(
          builder: (context) => AccountScreen(),
        );
      case "/upr":
        return MaterialPageRoute(
          builder: (context) => UserProfilePage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
