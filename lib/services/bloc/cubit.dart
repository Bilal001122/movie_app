import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/services/bloc/states.dart';
import '../cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    Text(
      'Search',
    ),
    Text(
      'Fav',
    ),
    Text(
      'Profile',
    ),
  ];

  void changeModeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppThemeChangedState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppThemeChangedState());
      });
    }
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppBottomNavBarChangedState());
  }
}
