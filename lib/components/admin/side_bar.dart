import 'package:finance_buddy/screens/admins/add_user.dart';
import 'package:finance_buddy/screens/admins/ptp_screen_admin.dart';
import 'package:finance_buddy/screens/reward.dart';
import 'package:flutter/material.dart';
import '../../screens/admins/admin_home_screen.dart';
import '../../screens/profile_screen.dart';
class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
       return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: const Text('Jigar Shah'),
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
            leading: Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: const Text('Rewards'),
            onTap: () {
              Navigator.pushNamed(context, Reward.id);
            },
          ),
        ],
      ),
    );
  }
}
