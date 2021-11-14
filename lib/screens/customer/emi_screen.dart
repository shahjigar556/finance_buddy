import 'package:flutter/material.dart';
import 'package:finance_buddy/components/customer/side_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class EMIScreen extends StatefulWidget {
  @override
   final id;
  EMIScreen({this.id});
  _EMIScreenState createState() => _EMIScreenState();
}

class _EMIScreenState extends State<EMIScreen> {
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
        'https://finance-buddy-api.herokuapp.com/users/getAllEMIOfLoanOfUser/${widget.id}';
    String token = await storage.read(key: 'token');
    http.Response response = await http
        .get(Uri.parse(url), headers: {'Authorization': "Bearer $token"});
    print('emi_screen');
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
                  'EMI Details !',
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
                          'EMI NO',
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
                          'Agent Name',
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
                          'Paid Date',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Last Date',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'PTP',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: List.generate(data.length, (index) {
                      var post = data[index];
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Text('${index+1}'),
                          ),
                          DataCell(
                            Text('${post['loanName']}'),
                          ),
                          DataCell(
                            Text(post['agentName']!=null?'${post['agentName']}':'-'),
                          ),
                          DataCell(
                            Text('${post['amount']}'),
                          ),
                          DataCell(
                            Text(post['isPaid']==true?'${post['paidAt']}':'-'),
                          ),
                          DataCell(
                            Text(post['isPaid']!=true?'${post['lastDate']}':'-'),
                          ),
                          DataCell(
                            Text(post['inPTP']==true?'Yes':'No'),
                          ),
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
