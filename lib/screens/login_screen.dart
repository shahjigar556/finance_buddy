import 'package:flutter/material.dart';
import 'home_screen.dart';
import './admins/admin_home_screen.dart';
import './customer/customer_home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  static String id = "login_screen";
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  TextEditingController name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  var loginfail = false;
  var loading = false;
  final storage = new FlutterSecureStorage();

  Map<dynamic, dynamic> data = {};
  Future<dynamic> login(String email, String pass) async {
    final String url = "https://finance-buddy-api.herokuapp.com/users/login";
    setState((){
      loading=true;
    });
    // print('api call started');
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'customerEmailId': email,
        'password': pass,
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
      await storage.write(key: "token", value: data['data']["token"]);
    } else {
      setState(() {
        loading=false;
        loginfail = true;
      });
      print(response.statusCode);
    }
    // print('api call ended');

  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading == true
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ))
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [Image.asset('images/card.png')],
                      ),
                    ),
                    Container(
                        // alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Finance Buddy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TextField(
                        controller: name_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "User Name",
                          errorText: loginfail ? 'email not match' : null,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: password_controller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          errorText: loginfail ? 'Password not match' : null,
                        ),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          //forgot password screen
                        },
                        child: Text('Forgot Password'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: TextButton(
                        onPressed: () async {
                          //login button pressed
                          await login(
                              name_controller.text, password_controller.text);
                          if (data['success'] &&
                              data['data']['role'] == 'agent') {
                            Navigator.pushNamed(context, HomeScreen.id);
                          } else if (data['success'] &&
                              data['data']['role'] == 'admin') {
                            Navigator.pushNamed(context, AdminHomeScreen.id);
                          } else if (data['success'] &&
                              data['data']['role'] == 'user') {
                            Navigator.pushNamed(context, CustomerHomeScreen.id);
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont Have an Account?'),
                          TextButton(
                            onPressed: () {
                              //Navigator.pushNamed(context,SignIn.id);
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
