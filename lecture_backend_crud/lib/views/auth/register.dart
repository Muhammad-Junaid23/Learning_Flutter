import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/user_model.dart';
import 'package:lecture_backend_crud/services/auth_service.dart';

import 'package:lecture_backend_crud/services/user_service.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Screen"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller:  nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10,),
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
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Contact",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10,),
            isLoading ? Center(child: CircularProgressIndicator(),)
                :ElevatedButton(onPressed: ()async{
              try{
                setState(() {
                  isLoading = true;
                });
                await AuthService().registerUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((value)async{
                  await UserService().createUser(
                      UserModel(
                          docId: value.uid,
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                  ).then((val){
                    isLoading = false;
                    setState(() {});
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text("Registration Successful"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, child: Text("OK"))
                        ],
                      );
                    }, );

                  });
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
