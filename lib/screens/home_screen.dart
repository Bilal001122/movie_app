import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/services/bloc/cubit.dart';
import 'package:movie_app/services/bloc/states.dart';
import 'package:movie_app/shared/widgets.dart';
import '../const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  appCubit.changeModeTheme();
                },
                icon: Icon(
                  appCubit.isDark ? Icons.sunny : Icons.nightlight_round,
                  color: appCubit.isDark ? kPrimaryColor : kDarkColor,
                ),
              ),
            ),
            SliverToBoxAdapter(
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
                    height: 350,
                    child: ClipRRect(
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(50),
                        bottomStart: Radius.circular(50),
                      ),
                      child: Image.asset(
                        'assets/images/img.png',
                        fit: BoxFit.fitWidth,
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
                            color: appCubit.isDark ? kDarkColor : kWhiteColor,
                            offset: const Offset(0, 1),
                            blurRadius: 100,
                            spreadRadius: 20,
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
                ],
              ),
            ),
            RowForHome(textLabelCategorie: 'Top Rated',movies: appCubit.topRatedMovies,),
            RowForHome(textLabelCategorie: 'Popular',movies: appCubit.popularMovies,),
            RowForHome(textLabelCategorie: 'Up Coming',movies: appCubit.upComingMovies,),
          ],
        );
      },
    );
  }
}
