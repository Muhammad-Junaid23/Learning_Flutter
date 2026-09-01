import 'package:flutter/material.dart';
import 'package:task_category_product/services/category_service.dart';
import 'package:task_category_product/services/product_service.dart';
import 'package:task_category_product/models/banner_model.dart';
import 'package:task_category_product/services/banner_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:task_category_product/views/banner/manage_banners.dart';
import 'package:task_category_product/views/product/product_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategoryId;

  final ProductServices productServices = ProductServices();
  final CategoryServices categoryServices = CategoryServices();

  int currentBannerIndex = 0;

  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ecommerce App"),
        actions: [
          IconButton(
            tooltip: "Manage Banners",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageBanners()),
              );
            },
            icon: const Icon(Icons.image),
          ),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     // TODO: Navigate to Create Product
          //   },
          //   icon: const Icon(Icons.add),
          //   label: const Text("Add Product"),
          // ),
          const SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // BANNER CAROUSEL
              // =========================

              StreamBuilder<List<BannerModel>>(
                stream: BannerServices().getAllBanners(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 230,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return SizedBox(
                      height: 230,
                      child: Center(child: Text("Error: ${snapshot.error}")),
                    );
                  }

                  final banners = snapshot.data ?? [];

                  if (banners.isEmpty) {
                    return Container(
                      height: 230,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("No banners available"),
                    );
                  }

                  return BannerCarousel(banners: banners);
                },
              ),

              const SizedBox(height: 20),

              // CATEGORIES + PRODUCTS
              const ProductSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerCarousel extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int currentBannerIndex = 0;

  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return Container(
        height: 230,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text("No banners available"),
      );
    }

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: widget.banners.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
                final banner = widget.banners[itemIndex];

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          banner.image ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.image_not_supported, size: 50),
                            );
                          },
                        ),
                      ),

                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.black87, Colors.transparent],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 25,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner.title ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              SizedBox(
                                width: 250,
                                child: Text(
                                  banner.description ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Shop Now →"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },

          options: CarouselOptions(
            height: 230,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enableInfiniteScroll: true,
            pauseAutoPlayOnTouch: true,

            onPageChanged: (index, reason) {
              setState(() {
                currentBannerIndex = index % widget.banners.length;
              });
            },
          ),
        ),

        const SizedBox(height: 10),

        // DOTS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (index) {
            final isSelected = currentBannerIndex == index;

            return GestureDetector(
              onTap: () {
                carouselController.animateToPage(index);

                setState(() {
                  currentBannerIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: isSelected ? 22 : 8,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
