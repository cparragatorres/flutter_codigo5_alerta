
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/alert_model.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/button_normal_widget.dart';

class AlertModalWidget extends StatefulWidget {
  List<TipoIncidente> typeAlerts;
  AlertModalWidget({required this.typeAlerts});
  @override
  State<AlertModalWidget> createState() => _AlertModalWidgetState();
}

class _AlertModalWidgetState extends State<AlertModalWidget> {

  int typeAlertValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typeAlertValue = widget.typeAlerts.first.id;
  }



  @override
  Widget build(BuildContext context) {
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
  }
}
