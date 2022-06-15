import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/pages/home_page.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/general_widgets.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_password_widget.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/input_textfield_widget.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final APIService _apiService = APIService();

  bool isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {

      });
      _apiService
          .login(_dniController.text, _passwordController.text)
          .then((value) {
        if (value != null) {
          isLoading = false;
          setState(() {

          });
          snackBarMessage(context, TypeMessage.loginSuccess);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
        } else {
          snackBarMessage(context, TypeMessage.error);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
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
          ),
          isLoading ?  Container(
            color: kBrandPrimaryColor.withOpacity(0.85),
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: kBrandSecondaryColor,
                  strokeWidth: 2.3,
                ),
              ),
            ),
          ): const SizedBox(),
        ],
      ),
    );
  }
}
