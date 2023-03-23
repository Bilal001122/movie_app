import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movie;
  final String textLabelCategorie;

  const MovieDetailScreen(
      {Key? key, required this.movie, required this.textLabelCategorie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'hero${movie.posterPath + textLabelCategorie}',
                    flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) {
                      switch (flightDirection) {
                        case HeroFlightDirection.push:
                          return ScaleTransition(
                            scale: animation.drive(
                              Tween<double>(begin: 0.0, end: 1).chain(
                                CurveTween(curve: Curves.bounceInOut),
                              ),
                            ),
                            child: toHeroContext.widget,
                          );
                        case HeroFlightDirection.pop:
                          return ScaleTransition(
                            scale: animation.drive(
                              Tween<double>(begin: 1, end: 0.0).chain(
                                CurveTween(curve: Curves.bounceInOut),
                              ),
                            ),
                            child: fromHeroContext.widget,
                          );
                      }
                    },
                    child: SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: movie.posterPath ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.play_arrow,
                          color: kWhiteColor,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.title != null && movie.title!.length > 25
                            ? movie.title!.substring(0, 25)
                            : movie.originalTitle != null &&
                                    movie.originalTitle!.length > 25
                                ? movie.originalTitle!.substring(0, 25)
                                : movie.name != null && movie.name!.length > 25
                                    ? movie.name!.substring(0, 25)
                                    : movie.originalName != null &&
                                            movie.originalName!.length > 25
                                        ? movie.originalName!.substring(0, 25)
                                        : movie.title ??
                                            movie.originalTitle ??
                                            movie.name ??
                                            movie.originalName ??
                                            '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Text('  |  '),
                      Text(
                        movie.releaseDate ?? movie.firstAirDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const Text('  |  '),
                      Row(
                        children: [
                          Text(
                            '${movie.voteAverage.toInt().toString()} ',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overview',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          movie.overview!,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
