import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertMapPage extends StatefulWidget {
  @override
  State<AlertMapPage> createState() => _AlertMapPageState();
}

class _AlertMapPageState extends State<AlertMapPage> {

  Map<MarkerId, Marker> _markers = {};
  Set<Marker> _markers2 = {};

  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(-16.389939, -71.547106),
    zoom: 7,
  );

  List myLocations = [
    {
      "latitude": -16.423201,
      "longitude": -71.547758,
      "text": "Marcador 1",
    },
    {
      "latitude": -16.627975,
      "longitude": -71.061622,
      "text": "Marcador 2",
    },
    {
      "latitude": -18.224637,
      "longitude": -69.404926,
      "text": "Marcador 3",
    },
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        compassEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(json.encode(mapStyle));
        },
        // markers: _markers.values.toSet(),
        markers: _markers2,
        onTap: (LatLng latLng) {
          MarkerId _myMarkerId = MarkerId(_markers.length.toString());
          Marker _myMarker = Marker(
            markerId: _myMarkerId,
            position: latLng,
            infoWindow: InfoWindow(
              title: "Hola",
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            onTap: (){
              print("MARKER");
            },
            draggable: true,
            onDragStart: (LatLng position){

            },
            onDrag: (LatLng position){
              print("DRAGGGGGG");
            },
            onDragEnd: (LatLng position){
              print("DRAGGGGGG ENDDDDDDDDDDDDDDDDD");
            }
          );
          _markers[_myMarkerId] = _myMarker;
          _markers2.add(_myMarker);
          setState((){});
        },
      ),
    );
  }
}
