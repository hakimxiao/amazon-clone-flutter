import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone_flutter/features/home/screens/home_screen.dart';
import 'package:amazon_clone_flutter/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_clone_flutter/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BottomBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(category: category),
      );

    case SearchScreen.routeName:
      var search = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: search),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) =>
            Scaffold(body: Center(child: Text('Screen does not exist!'))),
      );
  }
}
