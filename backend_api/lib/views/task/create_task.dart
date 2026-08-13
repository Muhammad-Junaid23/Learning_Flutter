import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: "Description",
              prefixIcon: Icon(Icons.description)
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :
              ElevatedButton(onPressed: ()async{
                try{
                  await TaskService().createTask(
                      token: tokenProvider.getToken().toString(),
                      description: descriptionController.text)
                      .then((val){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Success"),
                            content: Text(val.message!),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }, child: Text('OK'))
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
              }, child: Text("Create Task"))
        ],
      ),
    );
  }
}
