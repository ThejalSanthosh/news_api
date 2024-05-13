import 'package:api_state/constants/colorConstants.dart';
import 'package:api_state/controller/home_controller.dart';
import 'package:api_state/view/favorite_screen/favorite_screen.dart';
import 'package:api_state/view/news_read_screen/news_read_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? selectedDropDown;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeController>().getHeadlines();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenState = context.watch<HomeController>();
    return DefaultTabController(
      length: homeScreenState.lstCategories.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "NEWS",
              style: TextStyle(
                  color: ColorConstants.primaryBlack,
                  fontWeight: FontWeight.w600),
            ),
            actions: [
              DropdownButton(
                value: selectedDropDown,
                hint: Text("Select"),
                style: TextStyle(color: ColorConstants.primaryBlack),
                items: List.generate(
                    homeScreenState.lstCountry.length,
                    (index) => DropdownMenuItem(
                          child: Text(
                              homeScreenState.lstCountry[index].toUpperCase()),
                          value: homeScreenState.lstCountry[index],
                        )),
                onChanged: (value) {
                  selectedDropDown = value;
                  int selectedIndex = homeScreenState.lstCountry
                      .indexWhere((items) => items == value);
                  homeScreenState.getSelectedCountryIndex(selectedIndex);
                },
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
          body: Column(
            children: [
              CarouselSlider(
                  items: List.generate(
                      homeScreenState.newsResModel?.articles?.length ?? 0,
                      (index) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                fit: BoxFit.cover,
                                imageUrl: homeScreenState.newsResModel
                                        ?.articles?[index].urlToImage ??
                                    "",
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          )),
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: 10,
              ),
              TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  onTap: (value) {
                    homeScreenState.getSelectedCategoryIndex(value);
                  },
                  tabs: List.generate(
                    homeScreenState.lstCategories.length,
                    (index) => Tab(
                      child: Text(
                          "${homeScreenState.lstCategories[index].toUpperCase()}"),
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              homeScreenState.isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : homeScreenState.newsResModel?.articles?.length == null ||
                          homeScreenState.newsResModel?.articles?.length == 0
                      ? Center(
                          child: Text(
                          "No Data Found",
                          style: TextStyle(
                              color: ColorConstants.primaryBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ))
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
                                            builder: (context) =>
                                                NewsReadScreen(
                                                    articles:
                                                        homeScreenState
                                                            .newsResModel?.articles?[index]),
                                          ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            height: 200,
                                            imageUrl: homeScreenState
                                                    .newsResModel
                                                    ?.articles?[index]
                                                    .urlToImage ??
                                                "",
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assests/images/No-Image-Placeholder.svg.png"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            homeScreenState.newsResModel
                                                    ?.articles?[index].title ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            homeScreenState
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
                              itemCount: homeScreenState
                                      .newsResModel?.articles?.length ??
                                  0),
                        ),
            ],
          )),
    );
  }
}
