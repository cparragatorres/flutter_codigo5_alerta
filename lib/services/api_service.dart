import 'dart:convert';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:http/http.dart' as http;

class APIService {
  
  login(String username, String password) async{
    String _path = pathProduction + "/login/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "username": "47701122",
          "password": "3volution"
        },
      ),
    );
    if(response.statusCode == 200){

    }
  }

}
