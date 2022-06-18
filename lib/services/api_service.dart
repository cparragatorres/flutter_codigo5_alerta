import 'dart:convert';
import 'dart:io';
import 'package:flutter_codigo5_alerta/helpers/sp_global.dart';
import 'package:flutter_codigo5_alerta/models/alert_model.dart';
import 'package:flutter_codigo5_alerta/models/news_model.dart';
import 'package:flutter_codigo5_alerta/models/user_model.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class APIService {
  SPGlobal spGlobal = SPGlobal();

  Future<UserModel?> login(String username, String password) async {
    String _path = pathProduction + "/login/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "username": username,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(userMap["user"]);
      userModel.token = userMap["access"];
      spGlobal.token = userModel.token!;
      spGlobal.isLogin = true;
      return userModel;
    }
    return null;
  }

  Future<List<NewsModel>> getNews() async {
    String _path = pathProduction + "/noticias/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      List news = json.decode(source);
      List<NewsModel> newsModelList =
          news.map((e) => NewsModel.fromJson(e)).toList();
      return newsModelList;
    }
    return [];
  }

  Future<NewsModel?> updateNews(NewsModel newsModel) async {
    String _path = pathProduction + "/noticias/${newsModel.id}/";
    Uri _uri = Uri.parse(_path);
    print(newsModel.fecha);
    http.Response response = await http.patch(
      _uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "titulo": newsModel.titulo,
          "link": newsModel.link,
          "fecha": newsModel.fecha,
        },
      ),
    );

    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> newsMap = json.decode(source);
      NewsModel newsModel = NewsModel.fromJson(newsMap);
      return newsModel;
    }
    return null;
  }

  Future<NewsModel?> registerNews(NewsModel newsModel, File? imageNews) async {
    String _path = pathProduction + "/noticias/";
    Uri _uri = Uri.parse(_path);
    final request = http.MultipartRequest("POST", _uri);
    if (imageNews != null) {
      List<String> mimeType = mime(imageNews.path)!.split("/");
      http.MultipartFile file = await http.MultipartFile.fromPath(
        "imagen",
        imageNews.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
      request.files.add(file);
    }
    request.fields["titulo"] = newsModel.titulo;
    request.fields["link"] = newsModel.link;
    request.fields["fecha"] = newsModel.fecha;
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> newsMap = json.decode(source);
      NewsModel newsModel = NewsModel.fromJson(newsMap);
      return newsModel;
    }
    return null;
  }

  Future<NewsModel?> updateNews2(NewsModel newsModel, File? imageNews) async {
    String _path = pathProduction + "/noticias/${newsModel.id}/";
    Uri _uri = Uri.parse(_path);
    final request = http.MultipartRequest("PATCH", _uri);
    if (imageNews != null) {
      List<String> mimeType = mime(imageNews.path)!.split("/");
      http.MultipartFile file = await http.MultipartFile.fromPath(
        "imagen",
        imageNews.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
      request.files.add(file);
    }
    request.fields["titulo"] = newsModel.titulo;
    request.fields["link"] = newsModel.link;
    request.fields["fecha"] = newsModel.fecha;
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> newsMap = json.decode(source);
      NewsModel newsModel = NewsModel.fromJson(newsMap);
      return newsModel;
    }
    return null;
  }

  Future<List<AlertModel>> getAlerts() async {
    String _path = pathProduction + "/incidentes/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      List alerts = json.decode(source);
      List<AlertModel> alertModelList =
          alerts.map((e) => AlertModel.fromJson(e)).toList();
      return alertModelList;
    }
    return [];
  }

  Future<List<TipoIncidente>> getTypeAlerts() async {
    String _path = pathProduction + "/incidentes/tipos/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      List typeAlerts = json.decode(source);
      List<TipoIncidente> typeAlertModelList =
          typeAlerts.map((e) => TipoIncidente.fromJson(e)).toList();
      print(typeAlertModelList);
      return typeAlertModelList;
    }
    return [];
  }

  registerAlert() async {
    String _path = pathProduction + "/incidentes/crear/";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token ${spGlobal.token}",
      },
      body: json.encode(
        {
          "latitud": 0,
          "longitud": 0,
          "tipoIncidente": 5,
          "estado": "Abierto",
        },
      ),
    );
    print(response.statusCode);
  }
}
