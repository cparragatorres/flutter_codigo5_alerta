import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Bienvenido",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Por favor, ingresa tus credenciales",
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
            InputTextFieldWidget(hintText: "Nro. DNI"),


          ],
        ),
      ),
    );
  }
}
