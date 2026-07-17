import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridStaggered extends StatelessWidget {
  const GridStaggered({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text("Grid View Staggered"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
        child: StaggeredGrid.count(
            crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
            children: [
              StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: Container(color: Colors.red,),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: Container(color: Colors.green,),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Container(color: Colors.yellow,),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Container(color: Colors.orange,),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: Container(color: Colors.blue,),
              ),
            ],
        ),
      ),
    );
  }
}
