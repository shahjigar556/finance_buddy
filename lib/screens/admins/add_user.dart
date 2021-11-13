import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';


class AddUser extends StatefulWidget {
  static String id = "add_user";
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController customer_email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  TextEditingController contact_controller = TextEditingController();
  String? role = 'None';
  var loading = false;
  var data = {};
  Future<void> addUser() async {
    var url =
        'https://finance-buddy-api.herokuapp.com/admin/sendEmailToUserOnRegistration';
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    // print({
    //   'name': name_controller.text,
    //   'email': email_controller.text,
    //   'customerEmailId': customer_email_controller.text,
    //   "password": password_controller.text,
    //   "mobileNumber": contact_controller.text,
    //   "address": address_controller.text,
    // });
    setState(() {
      loading=true;
    });
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'name': name_controller.text,
        'email': email_controller.text,
        'customerEmailId': customer_email_controller.text,
        "password": password_controller.text,
        "mobileNumber": contact_controller.text,
        "address": address_controller.text,
      }),
    );

    if (response.statusCode == 201) {
      var x = jsonDecode(response.body);
      setState(() {
        data = x;
        loading=false;
      });
      SweetAlert.show(context,
          style: SweetAlertStyle.success,
          title: "User Added successfully");
    } else {
      setState((){
        loading=false;
      });
      print(response.statusCode);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Finance Buddy',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            tooltip: 'Settings',
            onPressed: () {
              print('settings icon pressed');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loading == true
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ))
            : ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text('Add User Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: name_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Name"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: email_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: customer_email_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Generated Email Id"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: password_controller,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: address_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Address"),
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
                      items: ['None', 'Agent', 'Customer']
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
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: contact_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Contact Number"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () async {
                        await addUser();
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
