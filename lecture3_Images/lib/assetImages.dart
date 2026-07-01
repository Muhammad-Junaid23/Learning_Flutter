import 'package:flutter/material.dart';

class AssetImages extends StatelessWidget {
  const AssetImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Assets Image",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.watch_later_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [

              /// Title
              const SizedBox(height: 10),

              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              /// Two Images
              Row(

                children: [

                  Expanded(
                    child: Image.asset(
                      "assets/images/hiring.jpg",
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Image.asset(
                      "assets/images/hiring.jpg",
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [

                  Icon(Icons.favorite_border, size: 38),

                  Icon(Icons.chat_bubble_outline, size: 38),

                  Icon(Icons.bookmark_border, size: 38),

                  Icon(Icons.person_outline, size: 38),
                ],
              ),

              const SizedBox(height: 8),

              /// Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [

                  Text("Favourite"),

                  Text("Comment"),

                  Text("Bookmark"),

                  Text("Profile"),
                ],
              ),

              const SizedBox(height: 30),

              /// Bottom Title
              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              /// Bottom Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/hiring.jpg",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}