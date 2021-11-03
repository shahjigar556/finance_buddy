import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  static String id="login_screen";
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  TextEditingController name_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset('images/card.png')
                  ],
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
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: name_controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "User Name"
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
                      labelText: "Password"
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  child: Text('Forgot Password'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color:Colors.blue
                ),
                child: TextButton(
                  onPressed: (){
                    //login button pressed
                    print(name_controller.text);
                    print(password_controller.text);
                    Navigator.pushNamed(context, HomeScreen.id);

                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Dont Have an Account?'
                    ),
                    TextButton(
                      onPressed: (){
                        //Navigator.pushNamed(context,SignIn.id);
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color:Colors.blue
                        ),
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