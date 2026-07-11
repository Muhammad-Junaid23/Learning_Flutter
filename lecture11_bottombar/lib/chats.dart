import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats", style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
        ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            chatsTile(
                "Ahmed",
              "Hi, How are you?",
            ),
            chatsTile(
              "Sana",
              "See You Soon",
            ),

            chatsTile(
              "Ali",
              "Meet me at 2PM",
            ),

            chatsTile(
              "Sofia",
              "Have a nice day",
            ),

            chatsTile(
              "Dawood",
              "See yaah!",
            ),
          ],
        ),
      ),
    );
  }
}



Widget chatsTile(
    String title,
    String description,
    ) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 15,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 18,
    ),
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [

        Icon(
          Icons.watch_later_outlined,
          color: Colors.white,
        ),

        SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 3,),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        Icon(
          Icons.arrow_right_alt_sharp,
          color: Colors.white,
        ),

      ],
    ),
  );
}