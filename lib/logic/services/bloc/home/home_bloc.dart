import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/logic/services/bloc/home/home_states.dart';
import 'package:movie_app/logic/services/cache_helper.dart';
import 'package:movie_app/logic/services/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDark = false;
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> popularMovies = [];
  List<MovieModel> upComingMovies = [];

  void changeModeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(HomeThemeChangedState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(HomeThemeChangedState());
      });
    }
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
        emit(HomeGetTrendingMoviesSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(HomeGetTrendingMoviesErrorState());
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
        emit(HomeGetPopularMoviesSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(HomeGetPopularMoviesErrorState());
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
        emit(HomeGetUpComingMoviesSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(HomeGetUpComingMoviesErrorState());
    });
  }

}
