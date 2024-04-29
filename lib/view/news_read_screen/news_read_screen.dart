import 'package:api_state/constants/colorConstants.dart';
import 'package:api_state/controller/favorite_controller.dart';
import 'package:api_state/model/news_api_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsReadScreen extends StatelessWidget {
  NewsReadScreen({super.key, required this.articles});

  final Article? articles;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("NEWS",
              style: TextStyle(
                  color: ColorConstants.primaryBlack,
                  fontWeight: FontWeight.w600)),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<FavoriteController>(context, listen: false)
                      .addToFavorite(articles!);
                },
                icon: Consumer<FavoriteController>(
                    builder: (context, value, child) => Icon(
                        value.lstArticle.contains(articles)
                            ? Icons.bookmark
                            : Icons.bookmark_border))),
            SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  try {
                    Share.share(articles?.url ?? "".toString());
                  } catch (e) {
                    print(e.toString());
                  }
                },
                icon: Icon(Icons.share)),
            SizedBox(
              width: 30,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: 200,
                imageUrl: articles?.urlToImage ?? "",
                errorWidget: (context, url, error) => Image.asset(
                    "assests/images/No-Image-Plac++++eholder.svg.png"),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                articles?.title ?? "",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                articles?.description ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(articles?.url ?? ""));
                  },
                  child: Text("Read More"))
            ],
          ),
        ),
      ),
    );
  }
}
