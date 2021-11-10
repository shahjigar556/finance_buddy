import 'package:finance_buddy/components/customer/side_bar.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  static String id="customer_home_screen";
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title:Text(
          'Finance Buddy',
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings,color: Colors.black),
            tooltip: 'Settings',
            onPressed: () {
              print('settings icon pressed');
            },
          ),
        ],
      ),
      drawer: SideBar(),
      body: Container(
        child: Text('Customer Screen'),
      ),
    );
  }
}
