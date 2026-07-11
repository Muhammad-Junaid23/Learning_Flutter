import 'package:flutter/material.dart';
import 'package:lecture12_parameters_provider/parameters/screen2.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 1 Parameter Passing"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>
                      Screen2(
                    title: "White fang",
                    description: "Lightning flash sword attack",
                  ))
              );
        }, child: Text("Go to Screen 2")),
      ),
    );
  }
}
