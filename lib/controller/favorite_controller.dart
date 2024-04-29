import 'package:api_state/model/news_api_model.dart';
import 'package:flutter/material.dart';

class FavoriteController with ChangeNotifier {
  List<Article> lstArticle = [];

  void addToFavorite(Article article) {
    if (lstArticle.contains(article)) {
      lstArticle.remove(article);
    } else {
      lstArticle.add(article);
    }

    notifyListeners();
  }
}
