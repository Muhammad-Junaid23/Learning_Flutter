import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_settings/loginscreen.dart';
import 'package:pinput/pinput.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // Switch
  bool isSwitchOn = false;

  //dropdown list
  List<String> countryList = ["Pakistan","Turkey","Iran","Malaysia"];
  String? selectedCountry;

  //slider
  double sliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Settings Page"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child:
          Center(
            child: Column(
              children: [
                Card(
                  color: isSwitchOn ? Colors.green : Colors.grey.withValues(alpha: 0.2),
                  child: ListTile(
                    leading: Icon(isSwitchOn ? Icons.wifi : Icons.wifi_1_bar_sharp),
                    title: Text("Wifi"),
                    subtitle: Text(isSwitchOn ? "ON" : "OFF"),
                    trailing: CupertinoSwitch(
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Colors.black,
                        thumbColor: Colors.red,
                        inactiveThumbColor: Colors.yellow,
                        value: isSwitchOn,
                        onChanged: (val){
                          setState(() {
                            isSwitchOn = val;
                          });
                        }),
                  ),
                ),
                if(isSwitchOn)
                  Center(child: Text("Available Wifi networks"),)
                else Center(child: Text("Turn on wifi"),),

                SizedBox(height: 20,),

                DropdownButton(
                  hint: Text("Select Country"),
                    value: selectedCountry,
                    items: countryList.map((val){
                      return DropdownMenuItem(
                          value: val,
                          child: Text(val.toString()));
                    }).toList(),
                    onChanged: (val){
                    setState(() {
                      selectedCountry = val;
                    });
                    }
                ),

                SizedBox(height: 20,),

                Slider(
                    value: sliderValue,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: sliderValue.round().toString(),
                    onChanged: (val){
                      setState(() {
                        sliderValue = val;
                      });
                    }),

                //OTP
                Pinput(
                  length: 5,
                  showCursor: true,
                  onCompleted: (val){
                    print(val);
                  },
                  defaultPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                ),


                // dialog box
                ElevatedButton(
                    onPressed: (){
                      showDialog(
                        barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Thank You!"),
                               content: Text("Login Successfully"),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("Back")),
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                },
                                    child: Text("Next")),
                              ],
                            );
                          },
                      );
                    },
                    child: Text("Show Dialog box")),


                SizedBox(height: 20,),
                // bottom sheet

                ElevatedButton(onPressed: (){
                  showModalBottomSheet(context: context,
                      builder: (BuildContext context){
                    return Padding(padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.cancel),
                            )
                          ],
                        ),
                        ListTile(
                          title: Text("Name"),
                          trailing: Text("Ahmed"),
                        ),
                        ListTile(
                          title: Text("Age"),
                          trailing: Text("20"),
                        ),
                        ListTile(
                          title: Text("City"),
                          trailing: Text("karachi"),
                        ),
                      ],
                    ),
                    );
                      });
                }, child: Text("Show Bottom Sheet")),


              ],
            ),
          ),
      ),
    );
  }
}
