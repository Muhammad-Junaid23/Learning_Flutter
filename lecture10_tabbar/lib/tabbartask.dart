import 'package:flutter/material.dart';

class TabBarTask extends StatelessWidget {
  const TabBarTask({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab bar'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          bottom: const TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs:[
                          Tab(text: "Home"),
                          Tab(text: "Profile"),
                          Tab(text: "Settings"),
                        ]
                    )
          ),
        body: TabBarView(
            children: [
              Center(child: SingleChildScrollView(
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
                      child: Image.asset("assets/images/hiring.jpg"),
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
              )),
              Center(child: SingleChildScrollView(
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
                      "Abdullah Rehman",
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
              )
              ),
              Center(child: SingleChildScrollView(
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
              )),
              ]),
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