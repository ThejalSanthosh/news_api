import 'package:api_state/constants/colorConstants.dart';
import 'package:api_state/view/favorite_screen/favorite_screen.dart';
import 'package:api_state/view/home_screen/home_screen.dart';
import 'package:api_state/view/search_screen/search_screen.dart';
import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

int bottomIndex = 0;

List<dynamic> lstScreens = [HomeScreen(), Searchscreen(), FavoriteScreen()];

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstScreens[bottomIndex],
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
          enableLineIndicator: true,
          selectedColor: ColorConstants.primaryBlack,
          lineIndicatorWidth: 4,
          indicatorType: IndicatorType.top,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          selectedIconSize: 20,
          unselectedIconSize: 20,
          onTap: (value) {
            bottomIndex = value;
            setState(() {});
          },
          currentIndex: bottomIndex,
          customBottomBarItems: [
            CustomBottomBarItems(icon: Icons.home, label: "Home"),
            CustomBottomBarItems(icon: Icons.search, label: "Search"),
            CustomBottomBarItems(
                icon: Icons.favorite_border, label: "Favorites")
          ]),
    );
  }
}
