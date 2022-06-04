import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/article_bloc/article_state.dart';
import 'package:news_app/bloc/article_bloc/article_bloc.dart';
import 'package:news_app/bloc/article_bloc/article_event.dart';
import 'package:news_app/data/models/api_model.dart';
import 'article_detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 82, 186, 255),
                title: Center(child: Text(" News App")),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      articleBloc.add(FetchArticleEvent());
                    },
                  ),
                ],
              ),
              body: Container(
                child: BlocListener<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    // ignore: missing_return
                    builder: (context, state) {
                      if (state is ArticleInitialState) {
                        return buildLoading();
                      } else if (state is ArticleLoadingState) {
                        return buildLoading();
                      } else if (state is ArticleLoadedState) {
                        return buildArticleList(state.articles);
                      } else if (state is ArticleErrorState) {
                        return buildErrorUi(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: SpinKitDoubleBounce(
        color: Colors.redAccent,
        size: 100.0,
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Color.fromARGB(255, 54, 184, 244)),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Container(
              child: ListTile(
                title: Text(articles[index].title,
                    style: TextStyle(
                      color: Colors.black,
                    )),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Hero(
                      tag: articles[index].urlToImage,
                      child: Image.network(
                        articles[index].urlToImage,
                        fit: BoxFit.cover,
                        height: 70.0,
                        width: 70.0,
                      )),
                ),

                // subtitle: Text(articles[index].publishedAt),
              ),
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10),
                gradient: new LinearGradient(
                    colors: [Color(0xffEE9CA7), Color(0xffFFDDE1)],
                    begin: Alignment.centerRight,
                    end: new Alignment(-1.0, -1.0)),
              ),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[index]);
            },
          ),
        );
        SizedBox(
          height: 5,
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Article article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        article: article,
      );
    }));
  }
}
