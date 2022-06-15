import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

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
