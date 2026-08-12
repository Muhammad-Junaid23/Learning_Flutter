import 'package:backend_api/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Name",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(Icons.lock),
            )
          ),

          isLoading ? Center(child: CircularProgressIndicator(),)
              : ElevatedButton(onPressed: ()async{
                try{
                  setState(() {
                    isLoading = true;
                  });
                  await AuthService().registerUser(name: nameController.text, email: emailController.text, password: passwordController.text)
                  .then((val){
                    setState(() {
                      isLoading = false;
                    });
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text(val.message!),
                        actions:[
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, child: Text("Ok"))
                        ],
                      );
                      },);
                  });
                }catch(e){
                  setState(() {
                  isLoading = false;
                  });
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Register"))
        ],
      ),
    );
  }
}