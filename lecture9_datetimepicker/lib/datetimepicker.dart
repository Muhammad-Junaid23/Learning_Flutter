import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text("Basketball Match", style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Colors.blue,
            ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMMEEEEd().format(selectedDate)),
                ElevatedButton(onPressed: (){
                  showDatePicker(context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100))
                      .then((value){
                        setState(() {
                          selectedDate = value!;
                        });
                  });
                },
                    child: Text("Selected Date")
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (selectedTime != null) ? 
                    Text(selectedTime!.format(context).toString())
                    :Text("No time selected"),
                ElevatedButton(onPressed: (){
                  showTimePicker(context: context,
                      initialTime: TimeOfDay.now())
                      .then((val){
                        setState(() {
                          selectedTime = val;
                        });
                  });
                }, child: Text("Select Time"))
              ],
            )
          ],
        ),

      ),
    );
  }
}
