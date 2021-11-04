import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static String id="profile_screen";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  var person={
    "name":"Jigar Shah",
  };
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0GQLZD6dfEaxDgOVPcgtAVZQtcojr6Qmn_A&usqp=CAU'),
                    radius: 100.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.indigo.shade800,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Hartik Suhagiya',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          indent: 50.0,
                          endIndent: 50.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.indigo.shade600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'BW298230NJ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          indent: 50.0,
                          endIndent: 50.0,
                        ),
                        Text(
                          'ID Number',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Mobile Number : 9876767120',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Email:shahjigar185@gmail.com',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'TRANSACTION REPORT',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.download_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.share_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
