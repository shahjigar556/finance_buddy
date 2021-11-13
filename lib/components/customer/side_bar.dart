import 'package:flutter/material.dart';
import 'package:finance_buddy/screens/customer/emi_calculator.dart';
import '../../screens/career_page.dart';
import '../../screens/todo.dart';
import '../../screens/contact.dart';

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
            title: const Text('EMI Calculator'),
            onTap: () {
              Navigator.pushNamed(context, EMICalculator.id);
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
        ],
      ),
    );
  }
}