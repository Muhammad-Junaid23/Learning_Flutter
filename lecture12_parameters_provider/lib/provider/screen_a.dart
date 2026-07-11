import 'package:flutter/material.dart';
import 'package:lecture12_parameters_provider/provider/provider.dart';
import 'package:lecture12_parameters_provider/provider/screen_b.dart';
import 'package:provider/provider.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen A Provider"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          userProvider.setTitle("Itachi Uchiha");
          userProvider.setDescription("The ninja who sacrifized everthing");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>
                      ScreenB())
          );
        }, child: Text("Go to Screen B")),
      ),
    );
  }
}
