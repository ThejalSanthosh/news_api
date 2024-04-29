import 'dart:convert';

import 'package:api_state/model/news_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchScreenController with ChangeNotifier {
  TextEditingController searchTextEditingController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  NewsResModel? newsResModel;
  Future searchNews(String query,BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      Uri url = Uri.parse(
          "https://newsapi.org/v2/everything?q=$query&apiKey=aa8aeffad29e4ba59f0f1b06ed69676e");

      var res = await get(url);

      if (res.statusCode == 200) {
        var decodedData = jsonDecode(res.body);

        newsResModel = NewsResModel.fromJson(decodedData);
      } else {
         
         final snackBar  = SnackBar(content: Text("Something went wrong"),behavior: SnackBarBehavior.floating,);

         ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
