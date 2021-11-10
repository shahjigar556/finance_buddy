import 'package:flutter/material.dart';
import '../../components/admin/side_bar.dart';
import '../admins/payment_screen.dart';


class CustomerScreen extends StatelessWidget {
  final cust;
  CustomerScreen({@required this.cust});
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
      body: ListView(
        children: <Widget>[
          CircleAvatar(
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0GQLZD6dfEaxDgOVPcgtAVZQtcojr6Qmn_A&usqp=CAU'),
            radius: 100.0,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '${cust['name']}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            color: Colors.blue.shade200,
            child: Text(
              'Collection Status : Pending',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            title: Text('Customer ID : ${cust['id']}'),
          ),
          ListTile(
            title: Text('Mobile No : ${cust['contact']}'),
          ),
          ListTile(
            title: Text('Email ID : harshadmehta2021@gmail.com'),
          ),
          ListTile(
            title: Text('Address :'),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            color: Colors.green,
            height: 300.0,
            width: 500.0,
            child: Center(
              child: Text(
                  'Area for Map'
              ),
            ),
          ),
          TextButton(
            onPressed: (){
               Navigator.pushNamed(context, PaymentScreen.id);
            },
            child: Text('Payment Details'),
          )
        ],
      ),
    );
  }
}
