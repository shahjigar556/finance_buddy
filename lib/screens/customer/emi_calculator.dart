import 'package:flutter/material.dart';
import 'dart:math';

class EMICalculator extends StatefulWidget {
  @override
  _EMICalculatorState createState() => _EMICalculatorState();
  static String id="emi_calculator_screen";
}

class _EMICalculatorState extends State<EMICalculator> {
  TextEditingController amountController = TextEditingController();
  double roi = 7.0;
  int months = 3;
  String emiValue = '';
  @override
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
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
            child: TextField(
              controller: amountController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText: "Amount"),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Rate of Interest',
                  style: TextStyle(fontSize: 18.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      roi.toString(),
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '%',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.lightBlue,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 15.0,
                    ),
                    overlayColor: Colors.blue,
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 30.0,
                    ),
                    activeTrackColor: Colors.blueGrey,
                    inactiveTrackColor: Colors.black,
                  ),
                  child: Slider(
                    value: roi.toDouble(),
                    min: 0.0,
                    max: 15.0,
                    onChanged: (double newValue) {
                      setState(() {
                        roi = double.parse(newValue.toStringAsFixed(1));
                      });
                    },
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.lightBlueAccent,
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Number of Months',
                  style: TextStyle(fontSize: 18.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      months.toString(),
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'months',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.lightBlue,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 15.0,
                    ),
                    overlayColor: Colors.blue,
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 30.0,
                    ),
                    activeTrackColor: Colors.blueGrey,
                    inactiveTrackColor: Colors.black,
                  ),
                  child: Slider(
                    value: months.toDouble(),
                    min: 3.0,
                    max: 36.0,
                    onChanged: (double newValue) {
                      setState(() {
                        months = newValue.round();
                      });
                    },
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                EMI e = EMI(
                    amount: double.parse(amountController.text),
                    rate: roi,
                    nom: months);
                emiValue = e.calculateEMI();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Center(
                child: Text(
                  'CALCULATE EMI',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ),
              height: 65.0,
              margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Your EMI Value',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              emiValue,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EMI {
  final double amount;
  final double rate;
  final int nom;
  EMI({required this.amount, required this.rate, required this.nom});
  double _emi=0.0;
  String calculateEMI() {
     double x=(rate/12)/100;
     int n=nom;
    _emi = (amount * x * (pow(1 + x, n)) / (pow(1 + x, n) - 1));
    return _emi.toStringAsFixed(2);
  }
}
