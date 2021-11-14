import 'package:finance_buddy/components/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentScreen extends StatefulWidget {
  static String id = "payment_screen";
  final idx;
  final name;
  PaymentScreen({this.idx,this.name});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  // var data=[
  //   {
  //     'id':1,
  //     'ref-no':'ABCD',
  //     'amount':"1000",
  //     "date":"12/10/2021",
  //   },
  //   {
  //     'id':2,
  //     'ref-no':'ABCD',
  //     'amount':"1000",
  //     "date":"12/10/2021",
  //   },
  //   {
  //     'id':3,
  //     'ref-no':'ABCD',
  //     'amount':"1000",
  //     "date":"12/10/2021",
  //   },
  //
  // ];
  List<dynamic> data = [];
  final storage = new FlutterSecureStorage();
  void initState() {
    super.initState();
    getData();
  }

  var loading = true;
  Future<void> getData() async {
    var url =
        'https://finance-buddy-api.herokuapp.com/users/getAllPaidEmisOfUserFromAdmin/${widget.idx}';
    String token = await storage.read(key: 'token');
    print('payment_screen');
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
                  CircleAvatar(
                    child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0GQLZD6dfEaxDgOVPcgtAVZQtcojr6Qmn_A&usqp=CAU'),
                    radius: 100.0,
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: Text(
                          '${widget.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Reference Number',
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
                            'Agent Assigned',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: List.generate(data.length, (index) {
                        var post = data[index];
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text('${post['_id']}'),
                            ),
                            DataCell(
                              Text('${post['amount']}'),
                            ),
                            DataCell(
                              Text('${post['agentName']}'),
                            ),
                            DataCell(
                              Text('${post['paidAt']}'),
                            ),
                          ],
                        );
                      }),
                    )),
                  )
                ],
              ));
  }
}
