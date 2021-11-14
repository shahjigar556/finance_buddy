import 'package:flutter/material.dart';
import '../../components/admin/side_bar.dart';
import '../admins/payment_screen.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
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
  var agent = 'None';
  var cust = {

  };
  List<dynamic> agents = [];
  final storage = new FlutterSecureStorage();
  var loading = true;
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
                    'Collection Status : Pending',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                cust['agent'] == null
                    ? Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Agent Assigned',
                          ),
                          value: agent,
                          onChanged: (String? val) {
                            setState(() {
                              agent = val == null ? '' : val;
                            });
                          },
                          items: ['None', 'Harshal Jain', 'Adnan Ahmed','Jigar Shah']
                              .map(
                                (disease) => DropdownMenuItem(
                                  value: disease,
                                  child: Text("$disease"),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : Container(),
                cust['agent'] == null?TextButton(
                  onPressed: (){
                    SweetAlert.show(context,
                        style: SweetAlertStyle.success,
                        title: "Success");
                  },
                  child:Text('Assign')
                ):Container(),
                ListTile(
                  title: Text('Customer ID : ${cust['_id']}'),
                ),
                ListTile(
                  title: Text('Mobile No : ${cust['mobileNumber']}'),
                ),
                ListTile(
                  title: Text('Email ID : ${cust['email']}'),
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
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PaymentScreen.id);
                  },
                  child: Text('Payment Details'),
                )
              ],
            ),
    );
  }
}
