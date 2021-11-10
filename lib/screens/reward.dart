import 'package:flutter/material.dart';
class Reward extends StatefulWidget {
  @override
  static String id="reward_screen";
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
  var data=[
    {
      "points":10
    },
    {
      "points":20
    }
  ];
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
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.card_giftcard,size: 40.0),
                  Text(
                    'Points:${data[index]['points']}'
                  ),
                  TextButton(
                    onPressed: (){

                    },
                    child: Text('Redeem Now'),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }
}
