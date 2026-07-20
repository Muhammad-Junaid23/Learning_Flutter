import 'package:flutter/material.dart';
import 'package:lecture_popupmenu_dropdown/login.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popup Menu"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          // popup menu
          PopupMenuButton(
              itemBuilder: (BuildContext context){
                return [
                  PopupMenuItem(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context)=>Login()
                          )
                          );
                        },
                        leading: Icon(Icons.tab),
                        title: Text("New Tab"),
                        trailing: Text("Ctrl N"),
                      )
                  ),
                  PopupMenuItem(child:
                  ListTile(
                    leading: Icon(Icons.window),
                    title: Text("New Window"),
                    trailing: Text("Ctrl W"),
                  )),
                  PopupMenuItem(child:
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    trailing: Text("Ctrl S"),
                  )),
                  PopupMenuItem(child:
                  ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text("Bookmark"),
                    trailing: Text("Ctrl B"),
                  )),
                  PopupMenuItem(child:
                  ListTile(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.delete),
                    title: Text("Delete"),
                    trailing: Text("Ctrl D"),
                  )),
                ];
              },
          )
        ],
      ),

      // drawer
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 100,
              color: Colors.yellow,
              child: DrawerHeader(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage("https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png"),
                      ),
                      Text("Ahmed")
                    ],
                  )
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
              },
              leading: Icon(Icons.home),
              title: Text("Home"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
              },
              leading: Icon(Icons.chat_sharp),
              title: Text("Chats"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
              },
              leading: Icon(Icons.person),
              title: Text("Profile"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
              },
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),


      body: Center(
        child: Column(
          children: [
            Text("Tap on 3 dots to open Popup menu"),

            // dialog box
            ElevatedButton(onPressed: (){
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Thank you"),
                      content: Text("Send Successfully"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child:
                        Text("Back")
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> Login()));
                        }, child: Text("Next")),
                      ],
                    );
                  },
              );
            }, child: 
            Text("Click to open dialog box")
            ),
            // bottom sheet
            ElevatedButton(onPressed:
            (){
             showModalBottomSheet(
                 isDismissible: false,
                 context: context,
                 builder: (BuildContext context){
                   return Column(
                     children: [
                       Text("Profile"),
                       ListTile(
                         onTap: (){
                           Navigator.pop(context);
                         },
                         leading: Icon(Icons.home),
                         title: Text("Home"),
                         trailing: Icon(Icons.arrow_forward_ios_outlined),
                       ),
                       ListTile(
                         onTap: (){
                           Navigator.pop(context);
                         },
                         leading: Icon(Icons.chat_sharp),
                         title: Text("Chats"),
                         trailing: Icon(Icons.arrow_forward_ios_outlined),
                       ),
                       ListTile(
                         onTap: (){
                           Navigator.pop(context);
                         },
                         leading: Icon(Icons.person),
                         title: Text("Profile"),
                         trailing: Icon(Icons.arrow_forward_ios_outlined),
                       ),
                       ListTile(
                         onTap: (){
                           Navigator.pop(context);
                         },
                         leading: Icon(Icons.logout),
                         title: Text("Logout"),
                         trailing: Icon(Icons.arrow_forward_ios_outlined),
                       ),
                     ],
                   );
                 }
             );
            }, child: Text("Show Bottom Sheet"))
          ],
        ),
      ),
    );
  }
}
