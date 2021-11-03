import 'package:flutter/material.dart';


class SideBar extends StatelessWidget {


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
              //Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: const Text('My Profile'),
            onTap: () {
              //Navigator.pushNamed(context, ProfilePage.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}