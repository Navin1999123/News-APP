import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/article_bloc/article_bloc.dart';
import 'package:news_app/data/repositories/article_repo.dart';
import 'package:news_app/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        create: (BuildContext context) =>
            ArticleBloc(repository: ArticleRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
}
