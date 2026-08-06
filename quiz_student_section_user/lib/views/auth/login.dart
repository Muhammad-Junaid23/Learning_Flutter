import 'package:flutter/material.dart';
import 'package:quiz_student_section_user/models/user_model.dart';
import 'package:quiz_student_section_user/services/auth_service.dart';
import 'package:quiz_student_section_user/views/auth/register.dart';
import 'package:quiz_student_section_user/views/auth/reset_password.dart';
import 'package:quiz_student_section_user/views/student/get_all_students.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
            },
                child: Text("Forgot Password")),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :
              ElevatedButton(onPressed: ()async{
                try{
                  setState(() {
                    isLoading = true;
                  });
                  await AuthService().loginUser(email: emailController.text, password: passwordController.text)
                  .then((value){
                    if(value.emailVerified == true){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetAllStudents()));
                    }else{
                      setState(() {
                        isLoading = false;
                      });
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Warning"),
                          content: Text("Verify your email"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("OK"))
                          ],
                        );
                      });
                    }
                  });
                }catch(e){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
                  child: Text("Login")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have account?"),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
              }, child: Text("Register"))
            ],
          )
        ],
      ),
      ),
    );
  }
}
