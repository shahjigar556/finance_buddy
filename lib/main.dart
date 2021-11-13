import 'package:finance_buddy/screens/admins/add_user.dart';
import 'package:finance_buddy/screens/admins/admin_home_screen.dart';
import 'package:finance_buddy/screens/admins/payment_screen.dart';
import 'package:finance_buddy/screens/career_page.dart';
import 'package:finance_buddy/screens/customer/customer_home_screen.dart';
import 'package:finance_buddy/screens/customer/emi_calculator.dart';
import 'package:finance_buddy/screens/reward.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/ptp_screen.dart';
import 'screens/target_screen.dart';
import 'screens/admins/ptp_screen_admin.dart';
import 'screens/todo.dart';
import 'screens/contact.dart';

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
        ProfileScreen.id:(context)=>ProfileScreen(),
        AdminHomeScreen.id:(context)=>AdminHomeScreen(),
        PTPScreen.id:(context)=>PTPScreen(),
        TargetScreen.id:(context)=>TargetScreen(),
        CustomerHomeScreen.id:(context)=>CustomerHomeScreen(),
        EMICalculator.id:(context)=>EMICalculator(),
        PaymentScreen.id:(context)=>PaymentScreen(),
        PTPScreenAdmin.id:(context)=>PTPScreenAdmin(),
        TodoScreen.id:(context)=>TodoScreen(),
        AddUser.id:(context)=>AddUser(),
        Reward.id:(context)=>Reward(),
        Contact.id:(context)=>Contact(),
        CareerForm.id:(context)=>CareerForm(),
      },
    );
  }
}

