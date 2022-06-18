

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';

class AlertPage extends StatefulWidget {
  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {

  final APIService _apiService = APIService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiService.getAlerts();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBrandPrimaryColor,
        title: Text("Alertas"),

      ),
    );
  }
}

