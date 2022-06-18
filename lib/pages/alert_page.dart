import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/alert_model.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';

class AlertPage extends StatefulWidget {
  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final APIService _apiService = APIService();
  List<AlertModel> alerts = [];
  List<TipoIncidente> typeAlerts = [];

  int typeAlertValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    alerts = await _apiService.getAlerts();
    typeAlerts = await _apiService.getTypeAlerts();
    typeAlertValue = typeAlerts.first.id;
    setState(() {});
  }

  showBottomForm() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 100,
                decoration: BoxDecoration(
                  color: kBrandSecondaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              const Text(
                "Por favor, selecciona y envia la alerta correspondiente",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              DropdownButton(
                value: typeAlertValue,
                items: typeAlerts
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.titulo,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (int? value) {
                  typeAlertValue = value!;
                  print(typeAlertValue);
                  setState((){});
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ButtonNormalWidget(
                title: "Enviar Alerta",
                onPressed: () {},
              ),
              const SizedBox(
                height: 10.0,
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
      backgroundColor: kBrandPrimaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBrandSecondaryColor,
        onPressed: () {
          showBottomForm();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: kBrandPrimaryColor,
        title: Text("Alertas"),
      ),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white.withOpacity(0.05),
            ),
            child: ListTile(
              title: Text(
                alerts[index].tipoIncidente.titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
              subtitle: Text(
                "${alerts[index].ciudadanoNombre} (${alerts[index].datosCiudadano.dni})",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 13.0),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    alerts[index].fecha,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    alerts[index].hora,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
