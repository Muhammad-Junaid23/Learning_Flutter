import 'package:flutter/material.dart';
import 'package:lecture5_pageview/models/onBoardingModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Pageview extends StatefulWidget {
  const Pageview({super.key});

  @override
  State<Pageview> createState() => _PageviewState();
}

class _PageviewState extends State<Pageview> {
  PageController pageController = PageController();
  List<OnBoardingModel> onBoardingList = [
     OnBoardingModel(image:"assets/images/1.png",title:"Welcome"),
    OnBoardingModel(image:"assets/images/2.png",title:"To"),
    OnBoardingModel(image:"assets/images/3.png",title:"Anime Verse"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: pageController,
                itemCount: onBoardingList.length,

                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      Image.asset(onBoardingList[index].image.toString(),width: 500,height: 300,),
                      Text(onBoardingList[index].title.toString(),style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900
                      ),
                      ),
                    ],
                  );
                },
            ),
          ),
          SmoothPageIndicator(
              controller: pageController,
              count:  onBoardingList.length,
              effect:  SwapEffect(),
              onDotClicked: (index){
              }
          ),
          ElevatedButton(onPressed: (){}, child: Text("Get Started"))

        ],
      ),
    );
  }
}
