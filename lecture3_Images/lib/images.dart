import 'package:flutter/material.dart';


class Images extends StatelessWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
         child: Column(
             children: [
               Container(
                 color: Colors.brown,
                 child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9YYh5Fk1u9VsWWr1MhkyQeOzeNbtnnMO96g&s",
                   width: 300, height: 200,
                   fit: BoxFit.cover,
         ),
               ),
               Text("Nature Image"),
               Image.asset("assets/images/ninja.jpg"),
        
               ClipRRect(
                 borderRadius: BorderRadius.circular(200),
                 child: Image.network("https://static.vecteezy.com/system/resources/thumbnails/049/855/168/small/nature-background-high-resolution-wallpaper-for-a-serene-and-stunning-view-free-photo.jpg")),
           ClipOval(child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvwyLpr9gi2DU_DsL66bRhmhKjloTF5YEtnQ&s")),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage("assets/images/ninja.jpg"),
            ),
               SizedBox(
                 height: 50,
                 width: double.infinity,
                 child: ElevatedButton(onPressed: (){},
                     style: ElevatedButton.styleFrom(
                       elevation: 4,
                       backgroundColor: Colors.deepOrangeAccent,
                       foregroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)
                       )
                     ),
                     child: Text("Thank You")),
               ),
               Text("Welcome"),
               TextButton(onPressed: (){},child:Text("Hi! there...")),
               GestureDetector(
                 onTap: (){},
                 child: Icon(Icons.settings)
               ),
               IconButton(onPressed: (){},icon: Icon(Icons.settings)),
             ],
         )
        ),
      ),
    );
  }
}
