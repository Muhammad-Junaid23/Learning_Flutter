import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/user_model.dart';
import 'package:lecture_backend_crud/provider/user_provider.dart';
import 'package:lecture_backend_crud/services/user_service.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    nameController = TextEditingController(
      text: userProvider.getUser().name.toString()
    );
    phoneController = TextEditingController(
      text: userProvider.getUser().phone.toString()
    );
    addressController = TextEditingController(
      text: userProvider.getUser().address.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hintText: "Phone",
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
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await UserService().updateUser(
                  UserModel(
                      docId: userProvider.getUser().docId.toString(),
                      name: nameController.text,
                      phone: phoneController.text,
                      address: addressController.text
                  )
              ).then((value)async{
                UserModel userModel =
                await UserService().getUserByID(userProvider.getUser().docId.toString());
                userProvider.setUser(userModel);
                isLoading = true;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("Profile Update Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("OK"))
                    ],
                  );
                },);
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
