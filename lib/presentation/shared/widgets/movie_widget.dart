import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';

class MovieWidget extends StatelessWidget {
  final MovieModel movie;
  final String textLabelCategorie;

  const MovieWidget(
      {super.key, required this.movie, required this.textLabelCategorie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Hero(
                      tag: 'hero${movie.posterPath + textLabelCategorie}',
                      child: Container(
                        height: double.infinity,
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ]),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/movie_detail',
                                arguments: {
                                  'movie': movie,
                                  'textLabelCategorie': textLabelCategorie
                                });
                          },
                          child: CachedNetworkImage(
                            key: UniqueKey(),
                            imageUrl: movie.posterPath ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        decoration:  const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kDarkColor,
                              blurRadius: 20,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                            Text(
                              movie.voteAverage.toString(),
                              style: const TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              movie.title ??
                  movie.name ??
                  movie.originalTitle ??
                  movie.originalName ??
                  '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
