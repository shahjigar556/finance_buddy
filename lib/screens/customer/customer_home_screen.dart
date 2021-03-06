import 'package:finance_buddy/components/customer/side_bar.dart';
import 'package:finance_buddy/screens/customer/emi_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerHomeScreen extends StatefulWidget {
  static String id="customer_home_screen";
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  final storage = new FlutterSecureStorage();
  List<dynamic> data = [];
  void initState() {
    super.initState();
    getData();
  }

  var loading = true;
  Future<void> getData() async {
    var url =
        'https://finance-buddy-api.herokuapp.com/users/getAllLoansOfUser';
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
                  'Hi User !',
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
                          // controller: name_controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Id"),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          // setState(() {
                          //   data = data
                          //       .where(
                          //           (i) => i['name'] == name_controller.text)
                          //       .toList();
                          // });
                          // name_controller.clear();
                        },
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
                          'Loan Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Total installments',
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
                            Text('${post['loanName']}'),
                          ),
                          DataCell(
                            Text('${post['totalInstallments']}'),
                          ),

                          DataCell(TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EMIScreen(id: post['loan']),
                                  ),
                                );
                              },
                              child: Text('Details'))),
                        ],
                      );
                    }),
                  )),
            )
          ],
        )
    );
  }
}
