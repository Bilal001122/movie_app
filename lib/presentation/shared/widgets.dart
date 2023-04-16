import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/logic/services/bloc/home/home_bloc.dart';
import 'package:movie_app/logic/services/bloc/home/home_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final VoidCallback? onPressed;

  const CustomButton(
      {super.key,
      required this.label,
      required this.color,
      this.icon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          foregroundColor: kWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: kWhiteColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: kWhiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : Text(
                label,
                style: GoogleFonts.poppins(
                  color: kWhiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final List<MovieModel> movies;
  final String label;
  final String textButton;
  final Color colorLabel;
  final Color colorTextButton;
  final String textLabelCategorie;

  const InfoRow({
    Key? key,
    required this.label,
    required this.textButton,
    required this.colorLabel,
    required this.colorTextButton,
    required this.movies,
    required this.textLabelCategorie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: colorLabel,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/see_more', arguments: {
              'movies': movies,
              'textLabelCategorie': textLabelCategorie,
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: kWhiteColor,
          ),
          child: Text(
            textButton,
            style: TextStyle(
              color: colorTextButton,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

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
                        decoration: const BoxDecoration(
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

class RowForHome extends StatelessWidget {
  final List<MovieModel> movies;
  final String textLabelCategorie;

  const RowForHome({
    super.key,
    required this.movies,
    required this.textLabelCategorie,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: InfoRow(
                  movies: movies,
                  label: textLabelCategorie,
                  textButton: 'See more',
                  colorTextButton: kPrimaryColor,
                  textLabelCategorie: textLabelCategorie,
                  colorLabel: cubit.isDark ? kWhiteColor : kDarkColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  height: 250,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MovieWidget(
                        movie: movies[index],
                        textLabelCategorie: textLabelCategorie,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                    itemCount: movies.isNotEmpty ? 10 : 0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/movie_detail', arguments: {
                                  'movie': movie,
                                  'textLabelCategorie': 'Top Rated',
                                });
                              },
                              child: Hero(
                                tag: 'hero${movie.posterPath + 'Top Rated'}',
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
                              decoration: const BoxDecoration(
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
                                          ).toString(),
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
    );
  }
}
