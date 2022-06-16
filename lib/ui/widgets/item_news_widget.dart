import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/models/news_model.dart';

class ItemNewsWidget extends StatelessWidget {
  NewsModel newsModel;

  ItemNewsWidget({
    required this.newsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ),
      width: double.infinity,
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          14.0,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              newsModel.imagen,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  "assets/images/imagex1.jpeg",
                  fit: BoxFit.cover,
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  )),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsModel.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    newsModel.fecha.toString().substring(0, 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
