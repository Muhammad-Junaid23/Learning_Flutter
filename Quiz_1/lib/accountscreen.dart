import 'package:flutter/material.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(onPressed: (){},
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text("Create Account", style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.black,
              ),
              ),
              const Text("Lorem Ipsum is simply dummy text and typesetting industry.",
                style: TextStyle(
                  color: Colors.black45,
                ),
                ),

              SizedBox(height: 35,),


              Align(
                alignment: Alignment.centerLeft,
                child: const Text("Full Name", style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900
              ),
              ),
              ),

              SizedBox(height: 5,),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  // labelText: "Name",
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )
                ),
              ),

              SizedBox(height: 15,),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text("Email", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900
                ),
                ),
              ),

              SizedBox(height:5,),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Enter your email",
                    // labelText: "Name",
                    filled: true,
                    fillColor: Colors.grey.withValues(alpha: 0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )
                ),
              ),

              SizedBox(height:15,),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text("Password", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900
                ),
                ),
              ),

              SizedBox(height: 5,),

              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                    hintText: "Enter your Password",
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    }, icon: Icon(!isPasswordVisible ? Icons.visibility : Icons.visibility_off)),
                    filled: true,
                    fillColor: Colors.grey.withValues(alpha: 0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )
                ),
              ),


              SizedBox(height: 25,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24)
                    ),
                    onPressed: (){},
                    child: Text("Create An Account")
                ),
              ),

        SizedBox(height: 20,),

        Row(
            children: [
              Expanded(
                  child: Divider()
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
               child: Text("OR Sign In With",style: TextStyle(
                 color: Colors.black54,
               ),)
              ),
              Expanded(
                  child: Divider(),
              ),
            ]
        ),

        SizedBox(height: 30,),
              
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("https://cdn-icons-png.flaticon.com/128/2702/2702602.png", width: 30,height: 30,),
            Image.network("https://cdn-icons-png.flaticon.com/128/0/747.png", width: 30,height: 30,),
            Image.network("https://cdn-icons-png.flaticon.com/128/3128/3128304.png", width: 30,height: 30,),

          ],
        ),

        SizedBox(height: 30,),

        RichText(
          textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 19),
              children: [
                TextSpan(text: "By Signing up you agree to our ",style: TextStyle(color: Colors.black54)),
                TextSpan(text: "Terms",style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: " and ",style: TextStyle(color: Colors.black54)),
                TextSpan(text: "Conditions of Use", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            )
        ),


        ],
      ),
      ),
    );
  }
}
