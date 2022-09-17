import 'package:amazone_clone/common/widgets/custom_bottom_bar.dart';
import 'package:amazone_clone/features/admin/add%20product/screens/add_product_screen.dart';
import 'package:amazone_clone/features/admin/models/product_model.dart';
import 'package:amazone_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazone_clone/features/product%20details/screens/product_details.dart';
import 'package:amazone_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case CustomBottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomBottomBar());

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());

    case CategoryDealsScreen.routeName:
      var categoryName = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                categoryName: categoryName,
              ));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(child: Text("Screen does not exist!...")),
              ));
  }
}
