import 'package:flutter/material.dart';
import 'package:lecture5_pageview/models/slidingModel.dart';


class Reelsview extends StatefulWidget {
  const Reelsview({super.key});

  @override
  State<Reelsview> createState() => _ReelsviewState();
}

class _ReelsviewState extends State<Reelsview> {
  PageController pageController = PageController();
  List<SlidingModel> slidingList = [
    SlidingModel(
      image: "assets/images/user1.jpg",
      title: "Interviews with designers of large companies",
      username: "Alex",
      date: "September 3",
    ),

    SlidingModel(
      image: "assets/images/user2.jpg",
      title: "Design Thinking for Beginners",
      username: "Sara",
      date: "September 10",
    ),

    SlidingModel(
      image: "assets/images/user3.jpg",
      title: "Become a Flutter Developer",
      username: "James",
      date: "October 5",
    ),
    SlidingModel(
      image: "assets/images/user4.jpg",
      title: "Become a Web Developer",
      username: "Haris",
      date: "Feb 10",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: slidingList.length,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [

                // Background Image
                Image.asset(
                  slidingList[index].image,
                  fit: BoxFit.cover,
                ),

                // Black Overlay
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Top Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                              child: Text(
                                slidingList[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const Icon(
                              Icons.close,
                              color: Colors.white,
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        // User Row
                        Row(
                          children: [

                            const CircleAvatar(
                              radius: 18,
                              backgroundImage:
                              AssetImage("assets/images/profile.png"),
                            ),

                            const SizedBox(width: 10),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [

                                    Text(
                                      slidingList[index].username,
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),

                                    const SizedBox(width: 10),

                                    const Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  slidingList[index].date,
                                  style: const TextStyle(
                                      color: Colors.white70),
                                )
                              ],
                            ),
                          ],
                        ),

                        const Spacer(),

                        const Text(
                          "37,256 views • 373 comments",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [

                            Icon(Icons.favorite_border,
                                color: Colors.white),

                            SizedBox(width: 18),

                            Icon(Icons.chat_bubble_outline,
                                color: Colors.white),

                            SizedBox(width: 18),

                            Icon(Icons.send,
                                color: Colors.white),

                            Spacer(),

                            OutlinedButton(
                              onPressed: () {
                                if (index == slidingList.length - 1) {
                                  pageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.keyboard_arrow_up, size: 18),
                                  SizedBox(width: 4),
                                  Text("Up Next"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
    );
  }
}
