import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/alert_model.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertMapPage extends StatefulWidget {
  List<AlertModel> alerts;

  AlertMapPage({required this.alerts});

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
  initState() {
    super.initState();
    // getMarkersLocation();
    getMarkerAlerts();
  }

  getMarkersLocation() {
    myLocations.forEach((element) {
      print(element);
      MarkerId _markerId = MarkerId(_markers2.length.toString());
      Marker _marker = Marker(
        markerId: _markerId,
        position: LatLng(element["latitude"], element["longitude"]),
      );
      _markers2.add(_marker);
      // _markers[_markerId] = _marker;
    });
    setState(() {});
  }

  getMarkerAlerts() {
    widget.alerts.forEach((element) {
      MarkerId _markerId = MarkerId(_markers2.length.toString());
      Marker _marker = Marker(
        markerId: _markerId,
        position: LatLng(element.latitud, element.longitud),
        onTap: () {
          showDetailAlert();
        },
      );
      _markers2.add(_marker);
    });

    setState(() {});
  }

  showDetailAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBrandPrimaryColor,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Detalle de la alerta",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Divider(
                indent: 12.0,
                endIndent: 12.0,
                color: Colors.white30,
              ),
              Text(
                "Secuestro",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Fecha: 12/12/2022",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                  Text(
                    "Hora: 12:22:11",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

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
        // onTap: (LatLng latLng) {
        //   MarkerId _myMarkerId = MarkerId(_markers.length.toString());
        //   Marker _myMarker = Marker(
        //       markerId: _myMarkerId,
        //       position: latLng,
        //       infoWindow: InfoWindow(
        //         title: "Hola",
        //       ),
        //       icon: BitmapDescriptor.defaultMarkerWithHue(
        //           BitmapDescriptor.hueAzure),
        //       onTap: () {
        //         print("MARKER");
        //       },
        //       draggable: true,
        //       onDragStart: (LatLng position) {},
        //       onDrag: (LatLng position) {
        //         print("DRAGGGGGG");
        //       },
        //       onDragEnd: (LatLng position) {
        //         print("DRAGGGGGG ENDDDDDDDDDDDDDDDDD");
        //       });
        //   _markers[_myMarkerId] = _myMarker;
        //   _markers2.add(_myMarker);
        //   setState(() {});
        // },
      ),
    );
  }
}
