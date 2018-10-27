import 'package:flutter/material.dart';
import 'package:attendence_app/auth.dart';
import 'package:attendence_app/auth_provider.dart';
import 'package:attendence_app/root_page.dart';
import 'package:attendence_app/pages/home-screen.dart';
import 'package:attendence_app/pages/splash-screen.dart';
import 'package:attendence_app/employee-panel/index.dart';

var routes = <String, WidgetBuilder>{
  "/splashScreen": (BuildContext context) => SplashScreen(),
  "/homeScreen": (BuildContext context) => HomeScreen(),
  "/rootPage": (BuildContext context) => RootPage(),
  "/employeePanel": (BuildContext context) => EmployeePanel(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Attendence App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: routes,
      ),
    );
  }
}