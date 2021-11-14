import 'package:flutter/material.dart';
import '../components/side_bar.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
  final id;
  CustomerScreen({this.id});
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  dynamic cust = {

  };
  var data = {};
  var collection_status="Not Paid";
  var loading = true;
  final storage = new FlutterSecureStorage();

  TextEditingController otp_controller = TextEditingController();
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url =
        'https://finance-buddy-api.herokuapp.com/users/getUserDetailsFromAgent/${widget.id}';
    String token = await storage.read(key: 'token');
    http.Response response = await http
        .get(Uri.parse(url), headers: {'Authorization': "Bearer $token"});
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        var x = jsonDecode(response.body);
        cust = x['data'];
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      print(response.statusCode);
    }
  }
  Future<void> sendOtp() async {
    final String url =
        "https://finance-buddy-api.herokuapp.com/otp/sendMobileOtp";
    String token = await storage.read(key: 'token');
    // setState(() {
    //   loading = true;
    // });
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, String>{'mobileNumber': '7977757495'}),
    );
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        loading=false;
      });
      print(data);
    } else {
      setState(() {
        loading = false;
      });
      print(response.body);
    }
  }
  var emi_data={};
  Future<void> sendEmiReminder() async {
     String url =
        "https://finance-buddy-api.herokuapp.com/otp/sendWhatsappMessage";
    String token = await storage.read(key: 'token');
    print({
      'mobileNumber': '7977757495',
      'date':'11/10/21',
      'customerName':'${cust['name']}',
      'amount':'${cust['amount']}'
    });
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'mobileNumber': '7977757495',
        'agentName':'${cust['agentName']}',
        'date':'11/10/21',
        'customerName':'${cust['name']}',
        'amount':'${cust['amount']}'
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        emi_data = jsonDecode(response.body);
        loading=false;
      });
      print(emi_data);
    } else {
      setState(() {
        loading = false;
      });
      print(response.body);
    }
    // sending email
     url =
        "https://finance-buddy-api.herokuapp.com/otp/sendEmailEMIReminder";
    response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'email': '${cust['email']}',
        'agentName':'${cust['agentName']}',
        'date':'11/10/21',
        'customerName':'${cust['name']}',
        'amount':'10,000'
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        emi_data = jsonDecode(response.body);
        loading=false;
      });
      print(emi_data);
    } else {
      setState(() {
        loading = false;
      });
      print(response.body);
    }

    // send email

  }
  var payment_data={};
  Future<void> sendPaymentLink() async {
    final String url =
        "https://finance-buddy-api.herokuapp.com/otp/sendPaymentLink";
    String token = await storage.read(key: 'token');
    // setState(() {
    //   loading = true;
    // });
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'mobileNumber': '${cust['contact']}',
        'date':'11/10/21',
        'customerName':'${cust['name']}',
        'amount':'${cust['amount']}'
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        payment_data = jsonDecode(response.body);
        loading=false;
      });
      print(data);
    } else {
      setState(() {
        loading = false;
      });
      print(response.body);
    }
  }
  var ptp_data={};
  Future<void> addToPTP() async {

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
      drawer: SideBar(),
      body: loading == true
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ))
          : ListView(
              children: <Widget>[
                CircleAvatar(
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0GQLZD6dfEaxDgOVPcgtAVZQtcojr6Qmn_A&usqp=CAU'),
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
                    'Collection Status : $collection_status',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: collection_status=="paid"?Colors.green:Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  title: Text('Customer ID : ${cust['_id']}'),
                ),
                ListTile(
                  title: Text('Mobile No : ${cust['mobileNumber']}'),
                ),
                ListTile(
                  title: Text('Email ID :${cust['email']}'),
                ),
                // ListTile(
                //   title: Text('Address :${cust['address']}'),
                // ),
                TextButton(
                  onPressed:(){
                    // MapsLauncher.launchCoordinates(37.4220041, -122.0862462);
                    MapsLauncher.launchQuery('Apollo Bandar, Colaba, Mumbai, Maharashtra 400001');
                  },
                  child: Text('Address'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Enter OTP'),
                            content: TextField(
                              controller: otp_controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Enter OTP"),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (otp_controller.text ==
                                      data['data']['otpCode'].toString()) {
                                    Navigator.pop(context);
                                    SweetAlert.show(context,
                                        style: SweetAlertStyle.success,
                                        title: "Success");
                                  } else {
                                    SweetAlert.show(context,
                                        subtitle: "Wrong OTP!",
                                        style: SweetAlertStyle.error);
                                  }
                                  otp_controller.clear();
                                },
                                child: const Text('Confirm OTP'),
                              ),
                            ],
                          ),
                        );
                        await sendOtp();
                      },
                      child: Text(
                        'Send OTP',
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () async{
                        await sendEmiReminder();
                        SweetAlert.show(context,
                            style: SweetAlertStyle.success,
                            title: "Success");
                      },
                      child: Text(
                        'Send EMI Reminder',
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async{
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('SMS SENT'),
                            content: Text(
                                'SMS has been sent successfully to your email id containing Transaction Receipt.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                {Navigator.pushNamed(context, HomeScreen.id)},
                                child: const Text('Back To Home Page'),
                              ),
                            ],
                          ),
                        );
                        await sendPaymentLink();
                      },
                      child: Text(
                        'Send Confirmation',
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        SweetAlert.show(context,
                            style: SweetAlertStyle.success,
                            title: "Added to PTP");
                      },
                      child: Text(
                        'Add to PTP',
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
