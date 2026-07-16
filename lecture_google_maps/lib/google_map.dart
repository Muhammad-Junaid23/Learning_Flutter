import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatelessWidget {
  GoogleMapScreen({super.key});

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Set<Marker> markers = {
    Marker(
       markerId: MarkerId("1"),
      position: LatLng(1.3521, 103.8198),
        infoWindow: InfoWindow(title: "Singapore")
    ),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(2.5000, 112.5000),
        infoWindow: InfoWindow(title: "Malaysia")
    ),
    Marker(
        markerId: MarkerId("3"),
        position: LatLng(34.083656, 74.797371),
        infoWindow: InfoWindow(title: "Kashmir Valley")
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Google Map"),
      ),
      body: GoogleMap(
          markers: markers,
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
              target: LatLng(33.5973, 73.0479),
            zoom: 15,
          ),
            zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
        },
      ),
    );
  }
}
