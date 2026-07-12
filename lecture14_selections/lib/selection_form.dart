import 'package:flutter/material.dart';

class SelectionForm extends StatefulWidget {
  const SelectionForm({super.key});

  @override
  State<SelectionForm> createState() => _SelectionFormState();
}

class _SelectionFormState extends State<SelectionForm> {
  final TextEditingController nameController = TextEditingController();
  
  String gender = 'Male';
  
  bool reading = false;
  bool gaming = false;
  bool traveling = false;

  String? country;
  
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selection Form'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8,),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Enter name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person)
                ),
              ),

              const SizedBox(height: 20,),

              const Text(
                "Select Gender",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioGroup<String>(
                  groupValue: gender,
                  onChanged: (value){
                    setState(() {
                      gender = value!;
                    });
                  },
                  child: const Column(
                    children: [
                      RadioListTile<String>(
                          title: Text('Male'),
                          value: 'Male',
                      ),
                      RadioListTile<String>(
                        title: Text('Female'),
                        value: 'Female',
                      ),
                    ],
                  ),
              ),

              const Divider(),

              const Text(
                'Select Hobbies',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              CheckboxListTile(
                  title: const Text('Reading'),
                  value: reading,
                  onChanged: (value){
                    setState(() {
                      reading = value!;
                    });
                  }
              ),

              CheckboxListTile(
                  title: const Text('Gaming'),
                  value: gaming,
                  onChanged: (value){
                    setState(() {
                      gaming = value!;
                    });
                  }
              ),

              CheckboxListTile(
                  title: const Text('Traveling'),
                  value: traveling,
                  onChanged: (value){
                    setState(() {
                      traveling = value!;
                    });
                  }
              ),

              const Divider(),

              const Text(
                'Select Country',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8,),

              DropdownButtonFormField<String>(
                  value: country,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.public),
                  ),
                  hint: const Text("Choose Country"),
                  items: const [
                    DropdownMenuItem(
                        value: 'Pakistan',
                        child: Text('Pakistan'),
                    ), DropdownMenuItem(
                        value: 'China',
                        child: Text('China'),
                    ), DropdownMenuItem(
                        value: 'Iran',
                        child: Text('Iran'),
                    ), DropdownMenuItem(
                        value: 'Turkey',
                        child: Text('Turkey'),
                    ),
                  ],
                  onChanged: (value){
                    setState(() {
                      country = value;
                    });
                  } ,
              ),

              const SizedBox(height: 30,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: (){
                      List<String> hobbies = [];

                      if(reading) hobbies.add('Reading');
                      if(gaming) hobbies.add('Gaming');
                      if(traveling) hobbies.add('Traveling');

                      showDialog(context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Form Submitted'),
                            content: Text(
                              'Name:${nameController.text}\n'
                                  'Gender: $gender\n'
                                  'Hobbies: ${hobbies.isEmpty ? 'None' : hobbies.join(',')}\n'
                                  'Country: ${country ?? 'Not Selected'}',
                            ),
                            actions: [
                            TextButton(
                                onPressed: ()=> Navigator.pop(context),
                                child: const Text('OK'),
                            ),
                            ],
                          ),
                      );
                    },
                    child: const Text('Submit')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}