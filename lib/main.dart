import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
      primaryColor: kAccentWhite,
      accentColor: kPrimaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 10.0,
        ),
      ),
    ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        ProfileScreen.id:(context)=>ProfileScreen()
      },
    );
  }
}

