import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible  = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Login",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.black38,
          ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: "Email",
              hintText: "example@gmail.com",
              prefixIcon: Icon(Icons.email),
              suffix: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              ),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            obscureText: !isPasswordVisible,
            controller: passwordController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: "Password",
              hintText: "ablated3456",
              prefixIcon: Icon(Icons.lock),
              suffix: IconButton(
                  icon: Icon(
                    !isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                onPressed: (){
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),

          ),
        SizedBox(
          height: 56,
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(onPressed: (){}, child: Text("Forgot Password?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.red,
            ),
          ),
          ),
        ),
        ),

          SizedBox(
            height: 46, width: double.infinity,
            child: ElevatedButton(onPressed: (){
              if(emailController.text.isEmpty){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Email is Required"),
                ),
                );
                return;
              }
              if(!emailController.text.contains("@")){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Email is invalid")));
                return;
              }
              if(passwordController.text.isEmpty){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Password is Required")));
                return;
              }
              if(passwordController.text.length < 8){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Password must be at least 8 digits")));
                return;
              }
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                 child: Text("Login")),
          ),
          SizedBox(height: 10,),
          Text("Don't have account ? ",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.black
            ),
          ),
          TextButton(onPressed: (){}, child: Text("SignUp"
            ,style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black54
            ),
          ),
          ),
        ],
      ),
      ),
    );
  }
}
