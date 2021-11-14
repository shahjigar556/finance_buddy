import 'package:finance_buddy/screens/admins/add_user.dart';
import 'package:finance_buddy/screens/admins/ptp_screen_admin.dart';
import 'package:finance_buddy/screens/customer/emi_calculator.dart';
import 'package:finance_buddy/screens/reward.dart';
import 'package:finance_buddy/screens/todo.dart';
import 'package:flutter/material.dart';
import '../../screens/admins/admin_home_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/career_page.dart';
import '../../screens/contact.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../screens/login_screen.dart';
class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
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
              Navigator.pushNamed(context, AdminHomeScreen.id);
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
            leading: Icon(Icons.note_add_sharp),
            title: const Text('Notes'),
            onTap: () {
              Navigator.pushNamed(context, TodoScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: const Text('Add User'),
            onTap: () {
              Navigator.pushNamed(context, AddUser.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: const Text('PTP list'),
            onTap: () {
              Navigator.pushNamed(context, PTPScreenAdmin.id);
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
