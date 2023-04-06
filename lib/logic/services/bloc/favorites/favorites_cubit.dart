import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/logic/services/bloc/favorites/favorites_state.dart';
import 'package:movie_app/logic/services/database.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  List<MovieModel> favorites = [];
  List<String> favoritesNames = [];
  List<String> favoritesTitles = [];
  Color color = Colors.white;

  void getFavorites() async {
    try {
      print('wewe');
      List<Map<String, dynamic>> map = await DataBase.getFromDB();
      print('hehehe');
      favorites = map.map(
        (e) {
          MovieModel movieModel = MovieModel.fromJson(json: e);
          return movieModel;
        },
      ).toList();
      favoritesNames = favorites.map((e) => e.name!).toList();
      favoritesTitles = favorites.map((e) => e.title!).toList();
      emit(GetFavoritesSuccess());
    } catch (e) {
      print(e.toString());
      emit(GetFavoritesError());
    }
  }

  Future<void> addToFavorites(MovieModel movie) async {
    try {
      await DataBase.insertToDB(
        name: movie.title ?? movie.name,
        overview: movie.overview,
        posterPath: movie.posterPath,
        voteAverage: movie.voteAverage.toString(),
        releaseDate: movie.releaseDate.toString(),
        firstAirDate: movie.firstAirDate.toString(),
        title: movie.title,
      );
      emit(AddToFavoritesSuccess());
      getFavorites();
    } catch (e) {
      emit(AddToFavoritesError());
    }
  }

  Future<void> deleteFromFavorites(MovieModel movie) async {
    try {
      await DataBase.deleteFromDB(
        id: movie.name ?? movie.title,
      );
      emit(DeleteFromFavoritesSuccess());
      getFavorites();
    } catch (e) {
      print(e.toString());
      emit(DeleteFromFavoritesError());
    }
  }

  void addAndDeleteHandling(MovieModel movie) async {
    try {
      getFavorites();
      List<String> list = [];
      list.clear();
      favorites.forEach((element) {
        list.add(element.name!);
        list.add(element.title!);
      });

      for (var element in favorites) {
        if (element.name == movie.name && (movie.name != null)) {
          await deleteFromFavorites(movie);
          color = Colors.white;
          emit(ChangeColorSuccess());
          break;
        }
        if (element.title == movie.title && (movie.title != null)) {
          await deleteFromFavorites(movie);
          color = Colors.white;
          emit(ChangeColorSuccess());
          break;
        }
      }

      if (list.contains(movie.name) == false &&
          list.contains(movie.title) == false) {
        await addToFavorites(movie);
        print('i am her \n\n\n');
        color = Colors.red;
        emit(ChangeColorSuccess());
      }
    } catch (e) {
      print(e.toString());
      emit(ChangeColorError());
    }
  }
}
