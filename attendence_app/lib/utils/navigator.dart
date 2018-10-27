import 'package:flutter/material.dart';

class MyNavigator{
 static void goToSplashScreen(BuildContext context) {
    Navigator.pushNamed(context, "/splashScreen");
  }
  static void goToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, "/homeScreen");
  }
   static void goToRootPage(BuildContext context) {
    Navigator.pushNamed(context, "/rootPage");
  }
  static void goToEmployeePanel(BuildContext context) {
    Navigator.pushNamed(context, "/employeePanel");
  }
}