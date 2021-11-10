import 'package:flutter/material.dart';
import 'package:finance_buddy/screens/customer/emi_calculator.dart';

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




        ],
      ),
    );
  }
}