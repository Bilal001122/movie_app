import 'package:flutter/material.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      child: Image.network(
                        movie.posterPath,
                        fit: BoxFit.fitWidth,
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
                      child: const Icon(
                        Icons.play_arrow,
                        color: kWhiteColor,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.title ??
                            movie.originalTitle ??
                            movie.name ??
                            movie.originalName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
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
                            '${movie.voteAverage.toString()} ',
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
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15,),
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
                          movie.overview,
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
