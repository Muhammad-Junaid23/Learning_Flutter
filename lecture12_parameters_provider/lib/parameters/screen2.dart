import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final String title;
  final String description;
  const Screen2({super.key,required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 2 parameter passing"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Text(title,style: TextStyle(fontSize: 30),),
          Text(description,style: TextStyle(fontSize: 30),),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Back"))
        ],
      ),
    );
  }
}
