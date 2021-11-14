import 'package:flutter/material.dart';
import '../utils/sales_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/side_bar.dart';
import 'package:pie_chart/pie_chart.dart';

class TargetScreen extends StatefulWidget {
  static String id="target_screen";
  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  @override
  Map<String, double> dataMap = {
    "Pending": 5,
    "Successful": 3,
    "PTP": 2,
    "Cancelled": 1,
  };
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
        body: Center(
            child: ListView(
              children: [
                Center(
                  child: Container(
                    margin:EdgeInsets.only(top: 10),
                    child:Text(
                        'Total Collection:500k',
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )
                    ),
                  ),
                ),
                Container(
                    child: SfCartesianChart(
                      // Initialize category axis
                        primaryXAxis: CategoryAxis(),

                        series: <LineSeries<SalesData, String>>[
                          LineSeries<SalesData, String>(
                            // Bind data source
                              dataSource:  <SalesData>[
                                SalesData('Jan', 35),
                                SalesData('Feb', 28),
                                SalesData('Mar', 34),
                                SalesData('Apr', 32),
                                SalesData('May', 40)
                              ],
                              xValueMapper: (SalesData sales, _) => sales.day,
                              yValueMapper: (SalesData sales, _) => sales.sales
                          )
                        ]
                    )
                ),
                PieChart(
                    dataMap: dataMap,
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                )
              ],
            )
        )
    );
  }
}
