import 'package:flutter/material.dart';

class MultipleSelection extends StatefulWidget {
  const MultipleSelection({super.key});

  @override
  State<MultipleSelection> createState() => _MultipleSelectionState();
}

class _MultipleSelectionState extends State<MultipleSelection> {
  List<int> selectedIndex = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hobbies"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onTap: (){
                setState(() {
                  if(selectedIndex.contains(index)){
                    selectedIndex.remove(index);
                  }
                  else{
                    selectedIndex.add(index);
                  }
                });

              },

              tileColor: selectedIndex.contains(index) ? Colors.blue: Colors.white,
              textColor: selectedIndex.contains(index) ? Colors.white: Colors.black,
              iconColor: selectedIndex.contains(index) ? Colors.white: Colors.black,
              leading: Icon(Icons.language),
              title: Text("English,$selectedIndex"),
              subtitle: Text("$index"),
              trailing: Icon(selectedIndex.contains(index) ? Icons.radio_button_checked : Icons.radio_button_off),
            ),
          );
        },
      ),
    );
  }
}