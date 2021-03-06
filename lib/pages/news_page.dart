import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/news_model.dart';
import 'package:flutter_codigo5_alerta/pages/general_form_page.dart';
import 'package:flutter_codigo5_alerta/services/api_service.dart';
import 'package:flutter_codigo5_alerta/ui/general/colors.dart';
import 'package:flutter_codigo5_alerta/ui/widgets/item_news_widget.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final APIService _apiService = APIService();
  List<NewsModel> news = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    isLoading = true;
    setState((){});
    _apiService.getNews().then((value) {
      news = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBrandPrimaryColor,
        title: Text("Noticias"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBrandSecondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeneralFormPage(isNew: true),
            ),
          ).then((value) {
            getData();
          });
        },
      ),
      body: !isLoading
          ? ListView.builder(
              itemCount: news.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemNewsWidget(
                  newsModel: news[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralFormPage(newsModel: news[index], isNew: false),
                      ),
                    ).then((value) {
                      getData();
                    });
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
