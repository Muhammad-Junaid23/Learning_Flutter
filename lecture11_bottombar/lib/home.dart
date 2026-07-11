import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ahmed",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Text("10-10-26"),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15,),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/images/ninja.jpg"),
              ),
              SizedBox(height: 15,),

              Text("Computer science is the field of science dealing with Technology.",
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.favorite_border, size: 35,),
                  Icon(Icons.chat_bubble_outline, size: 35,),
                  Icon(Icons.bookmark_border, size: 35,),
                ],
              )
            ],
          ),
      ),
    );
  }
}
