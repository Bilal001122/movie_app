import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/services/bloc/app_layout/app_layout_bloc.dart';
import 'package:movie_app/logic/services/bloc/app_layout/app_layout_states.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppLayoutCubit, AppLayoutStates>(
        listener: (context, state) {},
        buildWhen: (previous, current) {
          return (previous != current) &&
              (current is AppLayoutBottomNavBarChangedState ||
                  current is AppLayoutBottomNavBarChangedState);
        },
        builder: (context, state) {
          AppLayoutCubit appCubit = AppLayoutCubit.get(context);
          return Scaffold(
            body: appCubit.screens[appCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: appCubit.currentIndex,
              onTap: (value) {
                appCubit.changeBottomNavBar(value);
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home_filled,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Search',
                  icon: Icon(
                    Icons.search_sharp,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Wishlist',
                  icon: Icon(
                    Icons.bookmark,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(
                    Icons.person,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
