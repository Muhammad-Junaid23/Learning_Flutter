import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/provider/user_provider.dart';
import 'package:quiz_student_section_user/views/profile/update_profile.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Name: ${userProvider.getUser().name.toString()}"),
            SizedBox(height: 5,),
            Text("Email: ${userProvider.getUser().email.toString()}"),
            SizedBox(height: 5,),
            Text("Address: ${userProvider.getUser().address.toString()}"),
            SizedBox(height: 5,),
            Text("Phone: ${userProvider.getUser().phone.toString()}"),
            SizedBox(height: 5,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
            }, child: Text("Update Profile"))
          ],
        ),
      ),
    );
  }
}
