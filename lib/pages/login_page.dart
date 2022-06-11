import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widgets.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_password_widget.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  APIService _apiService = APIService();

  _login(){
    _apiService.login("asdasdasd", "asdasdasds");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                divider20(),
                SvgPicture.asset(
                  'assets/images/imagen2.svg',
                  height: 120,
                ),
                divider20(),
                const Text(
                  "Bienvenido",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "Por favor, ingresa tus credenciales",
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
                divider12(),
                InputTextFieldWidget(
                  hintText: "Nro. DNI",
                  maxLength: 8,
                  textInputType: TextInputType.number,
                  controller: _dniController,
                ),
                InputTextFieldPasswordWidget(
                  controller: _passwordController,
                ),
                divider20(),
                SizedBox(
                  width: double.infinity,
                  height: 54.0,
                  child: ElevatedButton(
                    onPressed: () {

                     _login();


                    },
                    style: ElevatedButton.styleFrom(
                      primary: kBrandSecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text(
                      "Iniciar Sesión",
                    ),
                  ),
                ),
                divider20(),
                RichText(
                  text: const TextSpan(
                      text: "¿Aún no estás registrado? ",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
                      ),
                      children: [
                        TextSpan(
                          text: " Regístrate",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: kBrandSecondaryColor,
                          ),
                        ),
                      ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
