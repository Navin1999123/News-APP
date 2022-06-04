import 'dart:convert';

import 'package:news_app/data/models/api_model.dart';
import 'package:news_app/res/strings.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRepository {
  Future<List<Article>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Article>> getArticles() async {
    var response = await http.get(Uri.parse(AppStrings.url));
    if (response.statusCode == 200) {
      print('response statusCode: ${response.statusCode}');

      var data = json.decode(response.body);
      print('Response.body : ${response.body}');
      List<Article> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
