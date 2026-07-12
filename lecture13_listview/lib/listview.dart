import 'package:flutter/material.dart';
import 'package:lecture13_listview/models/listModel.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<ListModel> chatList = [
    ListModel(name:"Ahmed",msg: "Welcome to flutter course"),
    ListModel(name:"ilyan",msg: "Welcome to MERN Stack course"),
    ListModel(name:"Shayan",msg: "Welcome to Graphics course"),
    ListModel(name:"Moiz",msg: "Welcome to Gaming course"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              color: Colors.grey,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/ninja.jpg"),
                ),
                title: Text(chatList[index].name.toString()),
                subtitle: Text(chatList[index].msg.toString()),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            );
          },
      ),
    );
  }
}
