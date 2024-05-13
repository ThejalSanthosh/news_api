import 'package:api_state/constants/colorConstants.dart';
import 'package:api_state/controller/favorite_controller.dart';
import 'package:api_state/model/news_api_model.dart';
import 'package:api_state/view/favorite_screen/widgets/contanier_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteScreenState = Provider.of<FavoriteController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites",
            style: TextStyle(
                color: ColorConstants.primaryBlack,
                fontWeight: FontWeight.w600)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          favoriteScreenState.lstArticleKeys.length == 0
              ? Center(
                  child: Text(
                  "Favorite Cart is Empty",
                  style: TextStyle(
                      color: ColorConstants.primaryBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))
              : Expanded(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        Article? article = favoriteScreenState.getArticle(favoriteScreenState.lstArticleKeys[index]);
                        return ContainerWidget(
                          article: article,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                      itemCount: favoriteScreenState.lstArticleKeys.length),
                ))
        ],
      ),
    );
  }
}
