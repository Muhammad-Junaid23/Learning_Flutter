import 'package:flutter/material.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab bar'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs:[
                      Tab(text: "Home",icon: Icon(Icons.home)),
                      Tab(text: "Settings",icon: Icon(Icons.settings)),
                      Tab(text: "Chats",icon: Icon(Icons.chat_sharp)),
                      Tab(text: "Profile",icon: Icon(Icons.person)),
                    ]
                  )
                ),
              )
          ),
        ),
        body: TabBarView(
            children: [
              Center(child:
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: Text("Email"),
                        hint: Text("abc@gmail.com"),
                        prefixIcon: Icon(Icons.email),
                        suffix: Icon(Icons.account_balance),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(

                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: Text("Password"),
                        hint: Text("**************"),
                        prefixIcon: Icon(Icons.lock),
                        suffix: Icon(Icons.visibility),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        )
                    ),

                  ),
                ],
              ),),
              Center(child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/1.png"),
                    ),
                    title: Text("Tom"),
                    subtitle: Text("Hi, How are You?"),
                    trailing: Text("6/24/2026"),
                  ),
                ],
              ),),
              Center(child: Image.asset("assets/images/2.png"),),
              Center(child: Icon(Icons.person,size: 70,),),
            ]),
      ),
    );
  }
}
