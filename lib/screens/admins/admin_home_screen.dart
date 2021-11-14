import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import '../admins/customer_screen.dart';
import '../../components/admin/side_bar.dart';
import 'package:http/http.dart' as http;

class AdminHomeScreen extends StatefulWidget {
  static String id = "admin_home_screen";
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  final storage = new FlutterSecureStorage();
  void initState() {
    super.initState();
    getData();
  }

  var loading = true;
  Future<void> getData() async {
    var url = 'https://finance-buddy-api.herokuapp.com/admin/getAllEMIS';
    String token = await storage.read(key: 'token');
    http.Response response = await http
        .get(Uri.parse(url), headers: {'Authorization': "Bearer $token"});
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        var x = jsonDecode(response.body);
        data = x['data'];
      });
    } else {
      setState(() {
        loading = false;
      });
      print(response.statusCode);
    }
  }

  TextEditingController name_controller = TextEditingController();
  List<dynamic> data = [];
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
                children: [
                  Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        'Hi Admin !',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: name_controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter Id"),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Search'),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              primary: Colors.white),
                        )
                      ],
                    )),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Amount',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Last-Date',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Loan-Name',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Details',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: List.generate(data.length, (index) {
                        var post = data[index];
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text('$index'),
                            ),
                            DataCell(
                              Text('${post['userName']}'),
                            ),
                            DataCell(
                              Text('${post['amount']}'),
                            ),
                            DataCell(
                              Text('${post['lastDate']}'),
                            ),
                            DataCell(
                              Text('${post['loanName']}'),
                            ),
                            DataCell(TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerScreen(id: post['user']),
                                    ),
                                  );
                                },
                                child: Text('Details')))
                          ],
                        );
                      }),
                    )),
                  )
                ],
              ));
  }
}
