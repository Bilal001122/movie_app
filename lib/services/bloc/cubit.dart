import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/services/bloc/states.dart';
import 'package:movie_app/services/dio_helper.dart';
import '../cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
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
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> popularMovies = [];
  List<MovieModel> upComingMovies = [];

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

  void getTopRatedMovies() {
    DioHelper.getData(
            url: '/tv/top_rated?api_key=5eef0526cc051ce2676063f75e029825',
            query: null)
        .then(
      (value) {
        value.data['results'].forEach((element) {
          topRatedMovies.add(
            MovieModel.fromJson(json: element),
          );
        });
        print(topRatedMovies[0].overview);
        emit(AppGetTrendingMoviesSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(AppGetTrendingMoviesErrorState());
    });
  }

  void getPopularMovies() {
    DioHelper.getData(
        url: '/movie/popular?api_key=5eef0526cc051ce2676063f75e029825',
        query: null)
        .then(
          (value) {
        value.data['results'].forEach((element) {
          popularMovies.add(
            MovieModel.fromJson(json: element),
          );
        });
        emit(AppGetPopularMoviesSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(AppGetPopularMoviesErrorState());
    });
  }

  void getUpComingMovies() {
    DioHelper.getData(
        url: '/movie/upcoming?api_key=5eef0526cc051ce2676063f75e029825',
        query: null)
        .then(
          (value) {
        value.data['results'].forEach((element) {
          upComingMovies.add(
            MovieModel.fromJson(json: element),
          );
        });
        emit(AppGetUpComingMoviesSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(AppGetUpComingMoviesErrorState());
    });
  }
}
