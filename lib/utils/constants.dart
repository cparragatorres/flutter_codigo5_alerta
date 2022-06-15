import 'dart:ui';

import 'package:flutter_codigo5_alerta/ui/general/colors.dart';

String pathProduction = "http://alertahunter.herokuapp.com/API";

enum TypeMessage {
  success,
  error,
  loginSuccess,
}

Map<TypeMessage, String> messages = {
  TypeMessage.loginSuccess: "Bienvenido, tus credenciales son correctas.",
  TypeMessage.success: "---",
  TypeMessage.error: "Hubo un incoveniente, por favor inténtalo nuevamente.",
};

Map<TypeMessage, Color> messageColor = {
  TypeMessage.loginSuccess: kSuccessColor,
  TypeMessage.success: kSuccessColor,
  TypeMessage.error: kErrorColor,
}