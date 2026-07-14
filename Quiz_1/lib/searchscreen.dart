import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  // Track selected category index
  int selectedCategoryIndex = 0;

  // Mock data for categories
  final List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": null},
    {"name": "Villas", "icon": Icons.home_work_outlined},
    {"name": "Hotels", "icon": Icons.apartment_outlined},
    {"name": "Apartments", "icon": Icons.domain_outlined},
  ];

  // Mock data for hotels
  final List<Map<String, dynamic>> hotels = [
    {
      "name": "Sapphire Cove Hotel",
      "location": "Key West, FL",
      "beds": 3,
      "baths": 3,
      "rating": 4.9,
      "price": 290,
      "image": "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=600&auto=format&fit=crop",
    },
    {
      "name": "Breeze Hill Hotel",
      "location": "Palm Springs, CA",
      "beds": 2,
      "baths": 3,
      "rating": 4.8,
      "price": 180,
      "image": "https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=600&auto=format&fit=crop",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back, size: 20)),
        title: const Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87),
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_outlined, size: 28, color: Colors.black87),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  height: 9,
                  width: 9,
                  decoration: const BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // --- SEARCH BAR ---
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.black38),
                  hintText: "Search...",
                  hintStyle: const TextStyle(color: Colors.black38),
                  suffixIcon: const Icon(Icons.tune_rounded, color: Colors.black54),
                  filled: true,
                  fillColor: const Color(0xFFFAFAFA),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color(0xFFF0F0F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- HORIZONTAL CATEGORIES ---
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF265AE8) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.transparent : const Color(0xFFEFEFEF),
                          ),
                        ),
                        child: Row(
                          children: [
                            if (categories[index]["icon"] != null) ...[
                              Icon(
                                categories[index]["icon"],
                                size: 18,
                                color: isSelected ? Colors.white : Colors.black45,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              categories[index]["name"],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black45,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),

              // --- HOTEL LIST ---h
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom:25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hotel Image Stack
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                hotel["image"],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Rating Badge
                            Positioned(
                              top: 15,
                              left: 15,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      hotel["rating"].toString(),
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Favorite Button
                            Positioned(
                              top: 15,
                              right: 15,
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.3),
                                radius: 18,
                                child: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Details Layout
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Details
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel["name"],
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hotel["location"],
                                  style: const TextStyle(color: Colors.black38, fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.king_bed_outlined, size: 18, color: Colors.black54),
                                    const SizedBox(width: 4),
                                    Text("${hotel["beds"]} bed", style: const TextStyle(color: Colors.black54, fontSize: 13)),
                                    const SizedBox(width: 12),
                                    const Icon(Icons.bathtub_outlined, size: 18, color: Colors.black54),
                                    const SizedBox(width: 4),
                                    Text("${hotel["baths"]} bathroom", style: const TextStyle(color: Colors.black54, fontSize: 13)),
                                  ],
                                )
                              ],
                            ),

                            // Right Price Details
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${hotel["price"]}",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF265AE8)),
                                ),
                                const Text(
                                  "Per Night",
                                  style: TextStyle(color: Colors.black38, fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}