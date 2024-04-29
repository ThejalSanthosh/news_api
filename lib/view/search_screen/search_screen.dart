import 'package:api_state/constants/colorConstants.dart';
import 'package:api_state/controller/search_controller.dart';
import 'package:api_state/view/news_read_screen/news_read_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seachScreenState = Provider.of<SearchScreenController>(context);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: seachScreenState.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                          color: ColorConstants.primaryBlack,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: seachScreenState.searchTextEditingController,
                      decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.transparent,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search for news",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstants.primaryBlack
                                      .withOpacity(.1)),
                              borderRadius: BorderRadius.circular(60))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Search is empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.grey)),
                            onPressed: () {
                              if (seachScreenState.formKey.currentState!
                                  .validate()) {
                                Provider.of<SearchScreenController>(context,
                                        listen: false)
                                    .searchNews(
                                        seachScreenState
                                            .searchTextEditingController.text,
                                        context);
                              }
                            },
                            child: Text(
                              "Search",
                              style:
                                  TextStyle(color: ColorConstants.primaryBlack),
                            )))
                  ],
                ),
              ),
              seachScreenState.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsReadScreen(
                                            articles: seachScreenState
                                                .newsResModel
                                                ?.articles?[index]),
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        height: 200,
                                        imageUrl: seachScreenState.newsResModel
                                                ?.articles?[index].urlToImage ??
                                            "",
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assests/images/No-Image-Placeholder.svg.png"),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        seachScreenState.newsResModel
                                                ?.articles?[index].title ??
                                            "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        seachScreenState
                                                .newsResModel
                                                ?.articles?[index]
                                                .description ??
                                            "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                          itemCount:
                              seachScreenState.newsResModel?.articles?.length ??
                                  0),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
