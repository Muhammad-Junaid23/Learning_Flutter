import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(
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
            settingTile(Colors.red, Icons.email, "Email"),
            settingTile(
              Colors.green,
              Icons.person,
              "USERNAME",
            ),

            settingTile(
              Colors.blueGrey,
              Icons.lock_outline,
              "PASSWORD",
            ),

            settingTile(
              Colors.deepPurple,
              Icons.call,
              "CONTACT",
            ),

            settingTile(
              Colors.blue,
              Icons.bookmark_border,
              "SAVED",
            ),

            settingTile(
              Colors.cyan,
              Icons.logout,
              "LOGOUT",
            ),
          ],
        ),
      ),
    );
  }
}



Widget settingTile(
    Color color,
    IconData icon,
    String title,
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
      color: color,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [

        Icon(
          icon,
          color: Colors.white,
        ),

        SizedBox(width: 15),

        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),

      ],
    ),
  );
}