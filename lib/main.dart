import 'package:api_state/controller/favorite_controller.dart';
import 'package:api_state/controller/home_controller.dart';
import 'package:api_state/controller/search_controller.dart';
import 'package:api_state/model/news_api_model.dart';
import 'package:api_state/view/bottom_navigation_screen/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(SourceAdapter());
  
  await Hive.openBox<Article>("articles");
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),ChangeNotifierProvider(create: (context) => FavoriteController(),),ChangeNotifierProvider(create: (context) => SearchScreenController(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavScreen(),
      ),
    );
  }
}
