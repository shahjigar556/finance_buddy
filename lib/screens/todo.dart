import 'package:flutter/material.dart';
class TodoScreen extends StatefulWidget {
  @override
   static String id="todo_screen";
  _TodoScreenState createState() => _TodoScreenState();
}

class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  dynamic data=[];
  TextEditingController todo_controller=TextEditingController();
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
      body:ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Notes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0
              ),
            ),
          ),
          Container(
            child: Column(
              children: List.generate(data.length,(index){
                return  ListTile(
                    leading: MyBullet(),
                    title: Text('${data[index]['description']}'),
                    trailing: IconButton(
                      onPressed: (){
                        setState((){
                          data.removeAt(index);
                        });
                      },
                      icon:Icon(Icons.delete)
                    )
                );
              }),
            ),
          ),
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('ADD TODO'),
                content: TextField(
                  controller:todo_controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Todo"
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => {
                      setState((){
                        data.add({
                          'description':todo_controller.text
                        });
                        todo_controller.clear();
                        Navigator.pop(context);
                    })
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            child: Text(
              'Add Todo'
            ),
          )
        ],
      )
    );
  }
}
