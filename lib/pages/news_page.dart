import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {


  final APIService _apiService = APIService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiService.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(
                "http://alertahunter.herokuapp.com/media/Noticias/pexels-photo-11181151.jpeg",
              ),
              Image.network(
                "http://alertahunter.herokuapp.com/media/Noticias/pexels-photo-12315780.jpeg",
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Text("sdsdsd");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
