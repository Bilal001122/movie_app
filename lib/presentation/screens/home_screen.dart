import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/services/bloc/home/home_bloc.dart';
import 'package:movie_app/logic/services/bloc/home/home_states.dart';
import 'package:movie_app/presentation/shared/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  int generateRandomNumber() {
    return Random().nextInt(5);
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
                          child: CachedNetworkImage(
                            imageUrl: cubit
                                        .upComingMovies[generateRandomNumber()]
                                        .posterPath !=
                                    null
                                ? cubit.upComingMovies[generateRandomNumber()]
                                    .posterPath!
                                : 'https://cdn11.bigcommerce.com/s-'
                                    'ydriczk/images/stencil/1280x1280/products'
                                    '/89058/93685/Joker-2019-Final-Style-steps-Poster'
                                    '-buy-original-movie-posters-at-starstills__62518'
                                    '.1669120603.jpg?c=2',
                            fit: BoxFit.cover,
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
                                children: const [
                                  CustomButton(
                                    label: 'Wishlist',
                                    color: kGreyColor,
                                    icon: Icons.add,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomButton(
                                      label: 'Details', color: kPrimaryColor),
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
                            cubit.changeModeTheme();
                          },
                          icon: Icon(
                            cubit.isDark ? Icons.sunny : Icons.nightlight_round,
                            color: cubit.isDark ? kPrimaryColor : kDarkColor,
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
