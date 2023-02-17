import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/services/bloc/cubit.dart';
import '../services/bloc/states.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
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
