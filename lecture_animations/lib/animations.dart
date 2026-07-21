import 'package:flutter/material.dart';

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> {
  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          animate = !animate;
        });
      },
          child:Icon(Icons.play_arrow_sharp),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.bounceInOut,
              height: animate ? 120 : 60,
              width: animate ? 200: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(animate ? 30 : 10),
                color: animate ? Colors.green : Colors.orange
              ),
            ),
            AnimatedOpacity(
                opacity: animate ? 1 : .3,
                duration: Duration(seconds: 1),
                child: FlutterLogo(size: 40,),
            ),
            SizedBox(height: 30,),
            AnimatedScale(scale: animate ? 4 : 1,
                duration: Duration(seconds: 1),
              child: Icon(Icons.favorite_border,color: Colors.pink ),
            ),
            AnimatedAlign(
                alignment: animate ? Alignment.centerLeft : Alignment.centerRight,
                duration: Duration(seconds: 2),
              child: Icon(Icons.arrow_back,color: Colors.brown ),
            ),
            AnimatedRotation(
                turns: animate ? 4 : 1,
                duration: Duration(seconds: 1),
              child: Icon(Icons.refresh_rounded,size: 50,),
            ),
            AnimatedSlide(
                offset: animate ? Offset(3, 4) : Offset.zero,
                duration: Duration(seconds: 1),
                child: Container(
                  height: 50,
                    width: 50,
                  color: Colors.orange,
                ),
            ),
            AnimatedCrossFade(
                firstChild: Icon(Icons.face,color: Colors.red,size: 40,),
                secondChild: Icon(Icons.star_rate,color: Colors.yellowAccent,size: 40,),
                crossFadeState: animate ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: Duration(seconds: 1)),
          ],
        ),
      ),
    );
  }
}
