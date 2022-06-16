import 'dart:convert';
import 'package:flutter_codigo5_alerta/helpers/sp_global.dart';
import 'package:flutter_codigo5_alerta/models/news_model.dart';
import 'package:flutter_codigo5_alerta/models/user_model.dart';
import 'package:flutter_codigo5_alerta/utils/constants.dart';
import 'package:http/http.dart' as http;

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
    http.Response response = await http.patch(
      _uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "titulo": newsModel.titulo,
          "link": newsModel.link,
        },
      ),
    );

    if(response.statusCode == 200){
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> newsMap = json.decode(source);
      NewsModel newsModel = NewsModel.fromJson(newsMap);
      return newsModel;
    }
    return null;

  }
}
