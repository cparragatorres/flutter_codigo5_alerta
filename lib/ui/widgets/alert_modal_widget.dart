import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/alert_aux_model.dart';
import 'package:flutter_codigo5_alerta/models/alert_model.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';

class AlertModalWidget extends StatefulWidget {
  List<TipoIncidente> typeAlerts;
  Function(int?) onSelected;

  AlertModalWidget({
    required this.typeAlerts,
    required this.onSelected,
  });

  @override
  State<AlertModalWidget> createState() => _AlertModalWidgetState();
}

class _AlertModalWidgetState extends State<AlertModalWidget> {
  int typeAlertValue = 0;
  APIService apiService = APIService();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typeAlertValue = widget.typeAlerts.first.id;
  }

  registerAlert() {
    isLoading = true;
    setState(() {});
    AlertAuxModel alertAuxModel = AlertAuxModel(
      latitud: -14.056228,
      longitud: -75.730303,
      tipoIncidente: typeAlertValue,
      estado: "Abierto",
    );
    apiService.registerAlert(alertAuxModel).then((value) {
      if (value != null) {
        Navigator.pop(context);
      }
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: height * 0.27,
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
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: typeAlertValue,
                    isExpanded: true,
                    items: widget.typeAlerts
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
                      setState(() {});
                    },
                    // onChanged: widget.onSelected,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ButtonNormalWidget(
                title: "Enviar Alerta",
                onPressed: () {
                  registerAlert();
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        isLoading ? Container(
          height: height * 0.27,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26),
            ),
          ),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ) : const SizedBox(),
      ],
    );
  }
}
