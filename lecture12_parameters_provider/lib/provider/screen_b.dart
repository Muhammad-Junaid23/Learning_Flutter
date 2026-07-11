import 'package:flutter/material.dart';
import 'package:lecture12_parameters_provider/provider/provider.dart';
import 'package:provider/provider.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen B Provider"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Text(userProvider.getTitle().toString(),style: TextStyle(fontSize: 30)),
          Text(userProvider.getDescription().toString(),style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
