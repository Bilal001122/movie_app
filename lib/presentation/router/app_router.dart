import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/presentation/screens/app_layout.dart';
import 'package:movie_app/presentation/screens/home_screen.dart';
import 'package:movie_app/presentation/screens/movie_details_screen.dart';
import 'package:movie_app/presentation/screens/see_more_screen.dart';
import '../screens/search_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final Map<String, dynamic> args =
        routeSettings.arguments as Map<String, dynamic>;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return const AppLayout();
          },
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      case '/search':
        return MaterialPageRoute(
          builder: (context) {
            return const SearchScreen();
          },
        );
      case '/movie_detail':
        return MaterialPageRoute(
          builder: (context) {
            return MovieDetailScreen(
              movie: args['movie'],
            );
          },
        );
      case '/see_more':
        return MaterialPageRoute(
          builder: (context) {
            return SeeMoreScreen(
              movies: args['movies'],
            );
          },
        );
      default:
        return null;
    }
  }
}
