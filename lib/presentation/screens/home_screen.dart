import 'dart:async';
import 'dart:math' show pi;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/logic/services/bloc/favorites/favorites_cubit.dart';
import 'package:movie_app/logic/services/bloc/favorites/favorites_state.dart';
import 'package:movie_app/logic/services/bloc/home/home_bloc.dart';
import 'package:movie_app/logic/services/bloc/home/home_states.dart';
import 'package:movie_app/presentation/shared/widgets/custom_button.dart';
import 'package:movie_app/presentation/shared/widgets/row_for_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getFirstMovieInUpComingMovies(List<MovieModel> upComingMovies) {
    return upComingMovies[0].posterPath;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return RefreshIndicator(
          color: kPrimaryColor,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            cubit.getPopularMovies();
            cubit.getTopRatedMovies();
            cubit.getUpComingMovies();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 12.0),
                sliver: SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kDarkColor,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 400,
                        child: ClipRRect(
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(50),
                            bottomStart: Radius.circular(50),
                          ),
                          child: cubit.upComingMovies.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: cubit.upComingMovies[0].posterPath,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: cubit.isDark ? kDarkColor : kWhiteColor,
                                offset: const Offset(0, 0),
                                blurRadius: 100,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'My List',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text(
                                    'Discover',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocConsumer<FavoritesCubit, FavoritesState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      FavoritesCubit favoritesCubit =
                                          FavoritesCubit.get(context);
                                      return CustomButton(
                                        label: 'Favorites',
                                        color: kGreyColor,
                                        icon: favoritesCubit.favoritesNames
                                                    .contains(cubit
                                                        .upComingMovies[0]
                                                        .name) ||
                                                favoritesCubit.favoritesNames
                                                    .contains(cubit
                                                        .upComingMovies[0]
                                                        .title)
                                            ? Icons.done
                                            : Icons.add,
                                        onPressed: () {
                                          favoritesCubit.addAndDeleteHandling(
                                              cubit.upComingMovies[0]);
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CustomButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          '/movie_detail',
                                          arguments: {
                                            'movie': cubit.upComingMovies[0],
                                            'textLabelCategorie': 'Top Rated',
                                          });
                                    },
                                    label: 'Details',
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: cubit.isDark ? kDarkColor : kWhiteColor,
                              offset: const Offset(0, 1),
                              blurRadius: 100,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            _animationController.forward();
                            if (_animationController.isCompleted) {
                              _animationController.reset();
                            }
                            cubit.changeModeTheme();
                            _animationController.forward();
                          },
                          icon: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateY(
                                    _animation.value,
                                  ),
                                child: Icon(
                                  Icons.sunny,
                                  color:
                                      cubit.isDark ? kPrimaryColor : kDarkColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RowForHome(
                textLabelCategorie: 'Top Rated',
                movies: cubit.topRatedMovies,
              ),
              RowForHome(
                textLabelCategorie: 'Popular',
                movies: cubit.popularMovies,
              ),
              RowForHome(
                textLabelCategorie: 'Up Coming',
                movies: cubit.upComingMovies,
              ),
            ],
          ),
        );
      },
    );
  }
}
