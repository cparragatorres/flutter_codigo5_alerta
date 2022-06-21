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

  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(-16.389939, -71.547106),
    zoom: 15,
  );

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
        markers: _markers.values.toSet(),
        onTap: (LatLng latLng) {
          MarkerId _myMarkerId = MarkerId(_markers.length.toString());
          Marker _myMarker = Marker(
            markerId: _myMarkerId,
            position: latLng,
          );
          _markers[_myMarkerId] = _myMarker;
          setState((){});
        },
      ),
    );
  }
}