import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';

class MovieWidgetForSearch extends StatelessWidget {
  final MovieModel movie;

  const MovieWidgetForSearch({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: SizedBox(
        height: 200,
        width: 130,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/movie_detail', arguments: {
              'movie': movie,
              'textLabelCategorie': 'Top Rated',
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 5,
                                  offset: Offset(0, 2),
                                )
                              ]),
                              child: Hero(
                                tag: 'hero${movie.posterPath + 'Top Rated'}',
                                child: CachedNetworkImage(
                                  key: UniqueKey(),
                                  imageUrl: movie.posterPath ?? '',
                                  fit: BoxFit.cover,
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
                                      movie.voteAverage is num
                                          ? movie.voteAverage.toStringAsFixed(1)
                                          : double.parse(
                                        movie.voteAverage,
                                      ).toStringAsFixed(1),
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
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title != null && movie.title != 'null'
                          ? movie.title!
                          : movie.originalTitle != null &&
                          movie.originalTitle != 'null'
                          ? movie.originalTitle!
                          : movie.name != null && movie.name != 'null'
                          ? movie.name!
                          : movie.originalName != null &&
                          movie.originalName != 'null'
                          ? movie.originalName!
                          : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        movie.overview!,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
