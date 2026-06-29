import 'package:flutter/material.dart';

class Lecture2 extends StatelessWidget {
  const Lecture2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        title: Text("POST",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            height: 5,
          ),),
        centerTitle: true,
        actions: [
          Icon(Icons.watch_later_outlined),
          SizedBox(width: 4,),
          Icon(Icons.notifications_none_outlined),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
        Row(
          children: [
            Icon(Icons.person_pin),
              SizedBox(width: 10,),
              Text('Lorem Ipsum',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              ),
          ]

        ), Text('Lorem ipsum is simple dummy text of printing and typesetting industry.'),
        SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:  [
                    Icon(Icons.favorite_border_outlined),
                    SizedBox(width: 4.0), // Space between icon and text
                    Text('Like'),
                  ],
                ),

                Row(
                  children:  [
                    Icon(Icons.comment_outlined),
                    SizedBox(width: 4.0),
                    Text('Comments'),
                  ],
                ),

                Row(
                  children:  [
                    Icon(Icons.bookmark_border_outlined),
                    SizedBox(width: 4.0),
                    Text('Saved'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),



            Text('Lorem ipsum is simple dummy text of printing and typesetting industry.'),
            Text('Lorem ipsum is simple dummy text of printing and typesetting industry.'),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.mark_email_unread),
                Text('Lorem Ipsum',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
                ),
                Icon(Icons.lock_outline),
              ],
            ),
            SizedBox(height: 10,),

            Text('Lorem ipsum is simple dummy text of printing and typesetting industry.'),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.watch_later_outlined),
                Icon(Icons.house_outlined),
                Icon(Icons.settings_outlined),
              ],
            ),
        ]
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        onPressed: () {  },
        icon: const Icon(Icons.add),
        label: const Text('ADD'),
      ),
    );
  }
}
