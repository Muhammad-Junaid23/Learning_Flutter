import 'package:figmaui/app_colors.dart';
import 'package:figmaui/model/servicemodel.dart';
import 'package:figmaui/model/topratedmodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  List<ServiceModel> services = [
    ServiceModel(
      image: "https://images.unsplash.com/photo-1626383137804-ff908d2753a2?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      userimage:"assets/images/user2.jpg",
      title: "Hair Styling & Cut",
      provider: "Sarah's Beauty Studio",
      price: "75",
      badge: "Popular",
      rating: 4.9,
    ),
    ServiceModel(
      image: "https://plus.unsplash.com/premium_photo-1664301887532-328f07bb2c24?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      userimage: "assets/images/user1.jpg",
      title: "Electrical Repair",
      provider: "TechFix Pro",
      price: "60",
      badge: "Top Rated",
      rating: 4.8,
    ),
  ];

  List<TopRatedModel> providers= [
    TopRatedModel(
    userimage:"assets/images/user2.jpg",
    title:"Sarah's Beauty Studio",
    category:"Beaty & Wellness, Health & Fitness",
    availability:"Available",
    reviews: 127,
    rating: 4.8,
    ),
    TopRatedModel(
      userimage:"assets/images/user4.jpg",
      title:"QuickClean Services",
      category:"Home Services",
      availability:"Available",
      reviews: 108,
      rating: 4.9,
    ),
    TopRatedModel(
      userimage:"assets/images/user1.jpg",
      title:"TechFix Pro",
      category:"Tech & Electronics",
      availability:"Available",
      reviews: 147,
      rating: 4.7,
    ),
    TopRatedModel(
      userimage:"assets/images/user3.jpg",
      title:"ProPlumb Experts",
      category:"Home Services · Plumbing",
      availability:"Available",
      reviews:77,
      rating:4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome back, Alex",style: TextStyle(color: AppColors.offWhiteColor,fontSize: 16),),
                        SizedBox(height: 5,),
                        Row(
                         children: [
                           Text("San Francisco, CA",
                             style: TextStyle(color: Colors.white,
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,

                             ),
                           ),
                           SizedBox(width: 5,),
                           Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                         ],
                       ),
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none, // Allows the badge to safely overflow the button boundaries
                          children: [
                            // Base Layer: Your original Notification Button
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                color: AppColors.offWhiteColor,
                              ),
                            ),

                            // Top Layer: The Red Notification Badge
                            Positioned(
                              top: 3,    // Adjust these values to position the badge perfectly
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.all(4.0), // Spacing around the text inside the circle
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,  // Minimum width ensures it stays a perfect circle
                                  minHeight: 16, // Minimum height ensures it stays a perfect circle
                                ),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10, // Small text size to fit the badge
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "What do you need today?",
                    hintStyle: TextStyle(color: AppColors.greyColor),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Try: haircut, TV repair, Cleaning",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
                ),
              ],
            ),
          ),
    Expanded(
      child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      ),
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // featured services
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Featured Services",style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w600,
               color: Colors.black,
              ),
              ),
              Text("See All",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGreenColor,
              ),
              ),
            ],
          ),

         const SizedBox(height: 15,),


          SizedBox(
            height: 275,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 10),
              itemCount: services.length,
              itemBuilder: (context, index) {
                ServiceModel service = services[index];

                return Container(
                  width: 320,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Image
                        Stack(
                          children: [

                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.network(
                                service.image,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Badge
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  service.badge,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Rating
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Text(
                                    service.rating.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                service.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [

                                  CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                    AssetImage(service.userimage),
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    service.provider,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [

                                      const Text(
                                        "Starting At",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),

                                      SizedBox(width: 10,),

                                      Text(
                                        "\$${service.price}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkGreenColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    onPressed: () {},
                                    child: const Text("View"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                );
              },
            ),
          ),


          const SizedBox(height: 15,),

          // top rated providers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Top Rated Providers",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              ),
              Text("See All",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGreenColor,
              ),
              ),
            ],
          ),

          const SizedBox(height: 15,),

          SizedBox(
            height: 550,

            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 10),
              itemCount: providers.length,
              itemBuilder: (context, index) {
                TopRatedModel provider = providers[index];

                return Container(
                  // width: 320,
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    provider.userimage,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 15,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(provider.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black
                                  ),
                                ),
                                Text(provider.category,style:
                                  TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.circle,
                                      color: Colors.green,size:10,),

                                   SizedBox(width: 5,),

                                    Text(
                                      provider.availability,
                                      style:
                                      TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.green,
                                      ),
                                    ),

                                    SizedBox(width: 30,),
                                    Icon(Icons.star_rate_rounded,
                                      color: Colors.yellow,size:25,),
                                    SizedBox(width: 4,),

                                    Text("${provider.rating}",style:
                                      TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),),

                                    SizedBox(width: 8,),

                                    Text("(${provider.reviews} reviews)",style:
                                      TextStyle(
                                        color: AppColors.lightGreyColor,
                                      ),),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(onPressed: (){},
                                icon: Icon(Icons.arrow_forward_ios_outlined)),
                          ],
                        )
                      ],
                    )
                );
              },
            ),
          ),

          const SizedBox(height: 10,),

          SizedBox(
            height: 210,
            width: double.infinity,
            child:
            Container(
              // width: 320,
              margin: const EdgeInsets.only(bottom: 10),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child:
              Stack(
                children: [
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/images/graph.png",
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    bottom: 20,
                    child: SizedBox(
                      width: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Need Service Now?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Find available providers in your area for immediate booking.",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primaryColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18  ,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Book Now",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
        ),
      ),
      ),
    ),
        ],
      ),
    );
  }
}
