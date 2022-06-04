import 'package:flutter/material.dart';
import 'package:news_app/data/models/api_model.dart';

class ArticleDetailPage extends StatelessWidget {
  Article article;

  ArticleDetailPage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 82, 186, 255),
        title: Text("News"),
      ),
      body: Column(
        children: [
          Container(
            child: Hero(
              tag: article.urlToImage,
              child: Image.network(article.urlToImage),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    article.title,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.all(5.0),
                  child: Text(
                    article.title,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    article.content,
                    style: TextStyle(
                      color: Colors.grey[800],
                      //fontWeight: FontWeight,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
