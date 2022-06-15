import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/news_model.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {


  final APIService _apiService = APIService();
  List<NewsModel> news = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData(){
    _apiService.getNews().then((value) {
      news = value;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias"),
      ),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index){
          return Text(news[index].titulo);
        },
      ),
    );
  }
}
