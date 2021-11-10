import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  static String id="add_user";
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  TextEditingController name_controller=TextEditingController();
  String? role='None';
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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              margin:EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  'Add User Details',
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  )
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextField(
                controller: name_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name"
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextField(
                controller: name_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email"
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextField(
                controller: name_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Generated Email Id"
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextField(
                controller: name_controller,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextField(
                controller: name_controller,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirm Password"
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextField(
                controller: name_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Address"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Role',
                ),
                value: role,
                onChanged: (String? val) {
                  setState(() {
                    role = val;
                    print(role);
                  });
                },
                items: ['None','Agent','Customer']
                    .map(
                      (disease) => DropdownMenuItem(
                    value: disease,
                    child: Text("$disease"),
                  ),
                )
                    .toList(),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextField(
                controller: name_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contact Number"
                ),
              ),
            ),
            Container(
              margin:EdgeInsets.only(top: 10),
              child: TextButton(
                onPressed: (){

                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
