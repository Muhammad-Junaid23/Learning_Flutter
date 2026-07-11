import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.account_circle_outlined,size: 120,),
              SizedBox(height: 15,),
              Text("Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
              Text(
                "Ahmed Ali",
                style: TextStyle(fontSize: 22),
              ),

              SizedBox(height: 10),

              Text(
                "Academy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),

              Text(
                "The Sky Coaching",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 10),

              Text(
                "University",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),

              Text(
                "University/College",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 10),

              Text(
                "City",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),

              Text(
                "Rawalpindi",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 10),

              Text(
                "Contact",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),

              Text(
                "0123456789",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 10),

              Text(
                "Address",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),

              Text(
                "Pakistan",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
