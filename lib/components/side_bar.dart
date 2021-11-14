import 'package:finance_buddy/screens/career_page.dart';
import 'package:finance_buddy/screens/login_screen.dart';
import 'package:finance_buddy/screens/profile_screen.dart';
import 'package:finance_buddy/screens/home_screen.dart';
import 'package:finance_buddy/screens/ptp_screen.dart';
import 'package:finance_buddy/screens/reward.dart';
import 'package:finance_buddy/screens/target_screen.dart';
import 'package:finance_buddy/screens/todo.dart';
import 'package:flutter/material.dart';
import 'package:finance_buddy/screens/contact.dart';
import 'package:finance_buddy/screens/customer/emi_calculator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SideBar extends StatelessWidget {
  final storage = new FlutterSecureStorage();
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0GQLZD6dfEaxDgOVPcgtAVZQtcojr6Qmn_A&usqp=CAU'),
              radius: 50,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: const Text('Rewards'),
            onTap: () {
              Navigator.pushNamed(context, Reward.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.note_add_sharp),
            title: const Text('Notes'),
            onTap: () {
              Navigator.pushNamed(context, TodoScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: const Text('EMI Calculator'),
            onTap: () {
              Navigator.pushNamed(context, EMICalculator.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: const Text('Analysis'),
            onTap: () {
              Navigator.pushNamed(context, TargetScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.closed_caption),
            title: const Text('Career'),
            onTap: () {
              Navigator.pushNamed(context, CareerForm.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: const Text('Contact'),
            onTap: () {
              Navigator.pushNamed(context, Contact.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: ()async{
              await storage.delete(key: 'token');
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        ],
      ),
    );
  }
}