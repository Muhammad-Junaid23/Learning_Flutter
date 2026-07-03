import 'package:flutter/material.dart';

class NetworkImages extends StatelessWidget {
  const NetworkImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(onPressed: (){},
            icon: const Icon(Icons.arrow_back),
      ),
        title: const Text(
          "Network Image",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: const Icon(Icons.watch_later_outlined)
          ),
          IconButton(onPressed: (){},
              icon: const Icon(Icons.notifications_none_outlined)
          ),
        ],
    ),
      floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      onPressed: (){},
          icon: const Icon(Icons.add),
          label: const Text(
          "ADD",
            style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),

      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person,size: 30,),
                  ),

                  const SizedBox(width: 12,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Author Name",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 5,),

                      Text(
                        "3-7-2026",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                    ],
                  ),

                ],
              ),
              
              const SizedBox(height: 20),
              
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoy9n09P7v6Az8j33GrqrD8FgdV-XeCZRs_FEKgK1ZEw&s=10",
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              const Text( "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.favorite_border,
                    size: 40,
                  ),
                  Icon(
                    Icons.chat_outlined,
                  size: 40,
                  ),
                  Icon(
                    Icons.bookmark_border,
                    size: 40,
                  ),
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
