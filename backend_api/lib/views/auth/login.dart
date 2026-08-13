import 'package:backend_api/models/user_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/provider/user_provider.dart';
import 'package:backend_api/services/auth_service.dart';
import 'package:backend_api/services/user_service.dart';
import 'package:backend_api/views/auth/register.dart';
import 'package:backend_api/views/task/get_all_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
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
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  await AuthService().loginUser(email: emailController.text, password: passwordController.text)
                      .then((val)async{
                        tokenProvider.setToken(val.token.toString());
                        UserModel userModel = await UserService().getProfile(token: val.token.toString());
                        userProvider.setUser(userModel);
                        setState(() {
                          isLoading = false;
                        });
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Login Successful"),
                            content: Text(val.message!),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>GetAllTask()));
                              }, child: Text("OK"))
                            ],
                          );
                        });
                  });
                }catch(e){
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Login")),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
          }, child: Text("Register"))
        ],
      ),
    );
  }
}