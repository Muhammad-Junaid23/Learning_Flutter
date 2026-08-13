import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTask extends StatefulWidget {
  final Task model;
  const UpdateTask({super.key,required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    descriptionController = TextEditingController(
      text: widget.model.description.toString()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
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
              await TaskService().updateTask(
                  token: tokenProvider.getToken().toString(),
                  description: descriptionController.text,
                  taskId: widget.model.id.toString())
                  .then((val){
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Success"),
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
          }, child: Text("Update Task"))
        ],
      ),
    );
  }
}
