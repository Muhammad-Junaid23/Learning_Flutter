import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventScheduler extends StatefulWidget {
  const EventScheduler({super.key});

  @override
  State<EventScheduler> createState() => _EventSchedulerState();
}

class _EventSchedulerState extends State<EventScheduler> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> pickDate() async {

    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: selectedDate,
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> pickTime() async {

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void postData() {

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Center(
            child: Text(
              "Done",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),

          content: const SizedBox(
            height: 70,
            child: Center(
              child: Text(
                "POSTED SUCCESSFULLY",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("BACK"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);

                titleController.clear();
                descriptionController.clear();
                authorController.clear();
              },
              child: const Text("OK"),
            ),

          ],
        );
      },
    );
  }

  Widget customField(String hint, TextEditingController controller) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(Icons.arrow_back),
        title: const Text("Date Time Picker"),
        actions: const [
          Icon(Icons.access_time),
          SizedBox(width: 15),
          Icon(Icons.notifications_none),
          SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Text(
              "Create a Post",
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Title",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            customField("Title", titleController),

            customField("Description", descriptionController),

            customField("Author Name", authorController),

            const SizedBox(height: 20),

            Text(
              DateFormat.yMMMMEEEEd().format(selectedDate),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                minimumSize: const Size(130, 40),
              ),

              onPressed: pickDate,

              child: const Text("Set Date"),
            ),

            const SizedBox(height: 25),

            Text(
              selectedTime.format(context),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                minimumSize: const Size(130, 40),
              ),

              onPressed: pickTime,

              child: const Text("Set Time"),
            ),

            const SizedBox(height: 25),

            ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                minimumSize: const Size(130, 40),
              ),

              onPressed: postData,

              child: const Text("Post"),
            ),

          ],
        ),
      ),
    );
  }
}