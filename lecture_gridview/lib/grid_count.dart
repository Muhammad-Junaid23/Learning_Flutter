import 'package:flutter/material.dart';

class GridCount extends StatelessWidget {
  const GridCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text("Grid View Count"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
         child: GridView.count(
           crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
           children: [
             Container(
               color: Colors.orange,
             ),Container(
               color: Colors.blue,
             ),Container(
               color: Colors.brown,
             ),Container(
               color: Colors.green,
             ),Container(
               color: Colors.blueGrey,
             ),Container(
               color: Colors.yellowAccent,
             ),
           ],
          ),
      ),
    );
  }
}
