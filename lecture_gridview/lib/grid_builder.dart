import 'package:flutter/material.dart';

class GridBuilder extends StatelessWidget {
  const GridBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid View Builder"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 80,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  color: Colors.green,
                  child: Text("Card $index"),
                );
              },
          ),
      ),
    );
  }
}