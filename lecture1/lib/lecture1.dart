import 'package:flutter/material.dart';

class Lecture1 extends StatelessWidget {
  const Lecture1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        title: Text("POST",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 5,
          ),),
        centerTitle: true,
        actions: [
          Icon(Icons.watch_later_outlined),
          Icon(Icons.notifications),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        onPressed: () {  },
        icon: const Icon(Icons.add),
        label: const Text('ADD'),
      ),
    );
  }
}