import 'package:api_state/constants/colorConstants.dart';
import 'package:api_state/model/news_api_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 150,
            width: 100,
            fit: BoxFit.cover,
            imageUrl: article.urlToImage ?? "",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Image.asset("assests/images/No-Image-Placeholder.svg.png"),
          ),
          // ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.withOpacity(.3),
                      border: Border.all(
                          color: ColorConstants.primaryBlack, width: .5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(article.title.toString()),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.author.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
