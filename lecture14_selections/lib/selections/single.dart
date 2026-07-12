import 'package:flutter/material.dart';

class SingleSelection extends StatefulWidget {
  const SingleSelection({super.key});

  @override
  State<SingleSelection> createState() => _SingleSelectionState();
}

class _SingleSelectionState extends State<SingleSelection> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (BuildContext context, int index){
          return Card(
            child: ListTile(
              onTap: (){
               setState(() {
                 selectedIndex = index;
               }); 
              },
              selected: selectedIndex == index,
              tileColor: Colors.blue,
              textColor: Colors.white,
              leading: Icon(Icons.language),
              title: Text("English"),
              subtitle: Text(selectedIndex == index ? "Selected" : "Unselected"),
              trailing: Icon(selectedIndex == index ? Icons.radio_button_checked : Icons.radio_button_off),
            ),
          );
          },
      ),
    );
  }
}
