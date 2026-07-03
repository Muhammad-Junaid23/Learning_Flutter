import 'package:flutter/material.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override

  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    contactController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back)),
        title: const Text("Registration"),
        centerTitle: true,
        actions: [
        IconButton(onPressed: (){}, icon:  Icon(Icons.access_time)),
          IconButton(onPressed: (){}, icon:  Icon(Icons.notifications_none)),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child:
                Text("Welcome to Registration Form",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                ),
                ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child:
                Text("Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
                SizedBox(height: 10,),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    labelText: "Email",
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    labelText: "Username",
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    labelText: "password",
                    suffixIcon: IconButton(
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  obscureText: !isConfirmPasswordVisible,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: "confirm password",
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        !isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: (){
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter contact",
                    labelText: "Contact",
                    suffixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            SizedBox(
              height: 12
            ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      if(emailController.text.trim().isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Email is required")),
                        );
                        return;
                      }
                      if (!emailController.text.contains("@")) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter a valid email")),
                        );
                        return;
                      }

                      if (usernameController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Username is required")),
                        );
                        return;
                      }

                      if (passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password is required")),
                        );
                        return;
                      }

                      if (passwordController.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password must be at least 8 characters")),
                        );
                        return;
                      }

                      if (confirmPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Confirm your password")),
                        );
                        return;
                      }

                      if (passwordController.text != confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Passwords do not match")),
                        );
                        return;
                      }

                      if (contactController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Contact number is required")),
                        );
                        return;
                      }

                      if (contactController.text.length != 11) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Contact number must be 11 digits")),
                        );
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Registration Successful!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade900,
                      foregroundColor: Colors.white60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text("Sign Up"),
                  ),
                ),
                SizedBox(
                    height: 12
                ),

            Align(
              alignment: Alignment.topLeft,
              child:
                const Text("Already have account?"),
            ),
                SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child:
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                )
            ),
              ],
            ),
          ),
      ),
    );
  }
}
