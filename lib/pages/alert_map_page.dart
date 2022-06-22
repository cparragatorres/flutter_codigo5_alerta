import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/alert_model.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/utils/map_style.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
          showDetailAlert(element);
        },
      );
      _markers2.add(_marker);
    });

    setState(() {});
  }

  showDetailAlert(AlertModel alertModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBrandPrimaryColor,
          contentPadding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Detalle de la alerta",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Divider(
                indent: 12.0,
                endIndent: 12.0,
                color: Colors.white30,
              ),
              Text(
                alertModel.tipoIncidente.titulo,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Fecha: ${alertModel.fecha}",
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text(
                    "Hora: ${alertModel.hora}",
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                alertModel.ciudadanoNombre,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                "DNI: ${alertModel.datosCiudadano.dni}",
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // String number = "232323";
                        await FlutterPhoneDirectCaller.callNumber(alertModel.datosCiudadano.telefono);

                      },
                      icon: const Icon(Icons.call),
                      label: const Text(
                        "Llamar",
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        primary: const Color(0xfff72585),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                      label: const Text(
                        "Ver en mapa",
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        primary: const Color(0xff3f37c9),
                      ),
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
