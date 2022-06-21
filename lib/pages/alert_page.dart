import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/alert_model.dart';
import 'package:flutter_codigo5_alerta/pages/alert_map_page.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/alert_modal_widget.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class AlertPage extends StatefulWidget {
  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final APIService _apiService = APIService();
  List<AlertModel> alerts = [];
  List<AlertModel> alertsAux = [];
  List<TipoIncidente> typeAlerts = [];
  List<TipoIncidente> typeAlerts2 = [];
  final DateFormat formatter = DateFormat('d-MMM-y');
  int typeAlertValue = 0;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    isLoading = true;
    setState(() {});
    alerts = await _apiService.getAlerts();
    alertsAux = alerts;
    typeAlerts = await _apiService.getTypeAlerts();
    typeAlerts2 = typeAlerts;
    typeAlerts2.insert(
      0,
      TipoIncidente(
        id: 0,
        value: 0,
        text: "Todos",
        titulo: "Todos",
        area: "SERENAZGO",
        nivel: "ALTA",
      ),
    );
    typeAlertValue = typeAlerts2.first.id;
    isLoading = false;
    setState(() {});
  }

  convertDate(String date) {
    DateTime dateTime = DateFormat('d-M-y', "es").parse(date);
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  showBottomForm() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertModalWidget(
          typeAlerts: typeAlerts,
          onSelected: (int? value) {},
        );
      },
    ).then((value) {
      getData();
    });
  }

  filterAlertType(int alertTypeId) {
    //
    alerts = alertsAux;
    if (alertTypeId != 0) {
      alerts = alerts
          .where((element) => element.tipoIncidente.id == alertTypeId)
          .toList();
    }
    setState(() {});
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlertMapPage()));
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: !isLoading
          ? Column(
              children: [
                //Dropdown...
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      value: typeAlertValue,
                      items: typeAlerts2
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(e.titulo),
                            ),
                          )
                          .toList(),
                      onChanged: (int? value) {
                        typeAlertValue = value!;
                        filterAlertType(typeAlertValue);
                        setState(() {});
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: alerts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
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
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13.0),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                convertDate(alerts[index].fecha),
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
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
