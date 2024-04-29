import 'dart:convert';

import 'package:api_state/model/news_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeController with ChangeNotifier {
  NewsResModel? newsResModel;
  bool isLoading = false;
  int selectedCategoryIndex = 0;
  int selectedCountryIndex = 0;
  List<String> lstCategories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  List<String> lstCountry = [
    "in",
    "ar",
    "ata",
    "ub",
    "eb",
    "gb",
    "rc",
    "ach",
    "cn",
    "co",
    "cu",
    "cz",
    "de",
    "eg",
    "fr",
    "gb",
    "gr",
    "hk",
    "hu",
    "id",
    "ie",
    "il",
    "ae",
    "it",
    "jp",
    "kr",
    "lt",
    "lv",
    "ma",
    "mx",
    "my",
    "ng",
    "nl",
    "no",
    "nz",
    "ph",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "sa",
    "se",
    "sg",
    "sk",
    "th",
    "tr",
    "tw",
    "ua",
    "us",
    "ve",
    "za"
  ];

  Future getHeadlines() async {
    try {
      isLoading = true;
      notifyListeners();
      Uri url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=${lstCountry[selectedCountryIndex]}&category=${lstCategories[selectedCategoryIndex]}&apiKey=aa8aeffad29e4ba59f0f1b06ed69676e");

      var res = await http.get(url);

      if (res.statusCode == 200) {
        print(res);
        var decodedData = jsonDecode(res.body);
        newsResModel = NewsResModel.fromJson(decodedData);
      } else {
        print("failed");
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void getSelectedCategoryIndex(int value) {
    selectedCategoryIndex = value;
    getHeadlines();
    notifyListeners();
  }

  void getSelectedCountryIndex(int value) {
    selectedCountryIndex = value;
    getHeadlines();
    notifyListeners();
  }
}
