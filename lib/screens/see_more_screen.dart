import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/widgets.dart';

class SeeMoreScreen extends StatelessWidget {
  final List<MovieModel> movies;

  const SeeMoreScreen({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GridView.count(
            physics:const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            childAspectRatio: 1/2,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            shrinkWrap: true,
            children: List.generate(movies.length, (index) {
              return MovieWidget(
                movie: movies[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}
