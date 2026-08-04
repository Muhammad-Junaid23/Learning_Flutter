import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/services/auth_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller:  emailController,
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await AuthService().resetPassword(
                email: emailController.text,)
                  .then((value){
                isLoading = false;
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("Link Send Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("OK"))
                    ],
                  );
                }, );
              });
            }catch(e){
              isLoading = false;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Reset Password"))
        ],
      ),
    );
  }
}