import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/logic/services/bloc/home/home_bloc.dart';
import 'package:movie_app/logic/services/bloc/home/home_states.dart';
import 'package:movie_app/presentation/shared/widgets/info_row.dart';
import 'package:movie_app/presentation/shared/widgets/movie_widget.dart';

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
