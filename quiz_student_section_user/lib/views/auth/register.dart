import 'package:flutter/material.dart';
import 'package:quiz_student_section_user/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register user"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
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
              isLoading ? Center(child: CircularProgressIndicator(),)
                  :ElevatedButton(onPressed: ()async{
                try{
                  setState(() {
                    isLoading = true;
                  });
                  await AuthService().registerUser(
                      email: emailController.text,
                      password: passwordController.text)
                      .then((val){
                      setState(() {
                        isLoading = false;
                      });
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
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }, child: Text("Register"))
          ]
          )
        )
    );
  }
}
