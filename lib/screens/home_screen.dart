import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Image.asset(
                      'assets/images/img.png',
                      fit: BoxFit.fitWidth,
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: InfoRow(
                  label: 'Marvel Studios',
                  textButton: 'See more',
                  colorTextButton: kPrimaryColor,
                  colorLabel: kWhiteColor,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  height: 200,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          width: 130,
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/img.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Stranger Things',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
