import 'package:api_state/model/news_api_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoriteController with ChangeNotifier {
  var box = Hive.box<Article>("articles");

  List lstArticleKeys = [];
  FavoriteController(){
    getInitKeys();
  }

  void getInitKeys() {
    lstArticleKeys = box.keys.toList();

    notifyListeners();
  }

  Future<void> addToFavorite(Article article) async {
    var key = lstArticleKeys.firstWhere(
      (element) => box.get(element)!.url == article.url,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    } else {
      await box.add(article);
    }
    getInitKeys();
  }

  Article? getArticle(var key) {
    return box.get(key);
  }

  bool isArticleAlreadySaved(Article article) {
    var key = lstArticleKeys.firstWhere(
      (element) => box.get(element)!.url == article.url,
      orElse: () => null,
    );

    return key != null;
  }
}
