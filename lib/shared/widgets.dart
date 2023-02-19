import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/bloc/cubit.dart';
import 'package:movie_app/services/bloc/states.dart';

import '../const/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;

  const CustomButton(
      {super.key, required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextButton(
        onPressed: () {},
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
  final String label;
  final String textButton;
  final Color colorLabel;
  final Color colorTextButton;

  const InfoRow(
      {Key? key,
      required this.label,
      required this.textButton,
      required this.colorLabel,
      required this.colorTextButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: colorLabel,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
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

  const MovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
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
                    child: Image.network(
                      movie.posterPath ?? '',
                      fit: BoxFit.cover,
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
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              movie.originalTitle ??
                  movie.title ??
                  movie.name ??
                  movie.originalName,
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

  const RowForHome(
      {super.key, required this.movies, required this.textLabelCategorie});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: InfoRow(
                  label: textLabelCategorie,
                  textButton: 'See more',
                  colorTextButton: kPrimaryColor,
                  colorLabel: appCubit.isDark ? kWhiteColor : kDarkColor,
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
