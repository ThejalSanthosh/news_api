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
    "ae",
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
    "in",
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
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=${lstCountry[selectedCountryIndex]}&category=${lstCategories[selectedCategoryIndex]}&apiKey=aa8aeffad29e4ba59f0f1b06ed69676e");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      print(res);
      var decodedData = jsonDecode(res.body);
      newsResModel = NewsResModel.fromJson(decodedData);
      notifyListeners();
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  void getSelectedCategoryIndex(int value) {
    selectedCategoryIndex = value;
    getHeadlines();
    notifyListeners();
  }

  void getSelectedCountryIndex(int value){
    selectedCountryIndex=value;
    getHeadlines();
    notifyListeners();
  }

//   Future getData() async {
//     isLoading = true;
//     notifyListeners();
// // Step 1
//     Uri url = Uri.parse(
//         "https://newsapi.org/v2/everything?q=keyword&apiKey=aa8aeffad29e4ba59f0f1b06ed69676e");

// // step 2
//     var res = await http.get(url);

// // step 3

//     if (res.statusCode == 200) {
//       // step 4-decode
//       var decodedData = jsonDecode(res.body);

// // step 5-convert to model class
//       newsResModel = NewsResModel.fromJson(decodedData);
// // step 6- state update
//     } else {
//       print("Failed");
//     }
//     isLoading = false;
//     notifyListeners();
//   }
}
