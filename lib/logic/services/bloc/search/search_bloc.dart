import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/models/movie.dart';
import 'package:movie_app/logic/services/bloc/search/search_states.dart';
import 'package:movie_app/logic/services/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  List<MovieModel> searchMovies = [];

  void getSearchMovie({required String str}) {
    emit(SearchGetSearchMoviesLoadingState());
    searchMovies = [];
    DioHelper.getData(
        url: '/search/movie?api_key=5eef0526cc051ce2676063f75e029825',
        query: {
          'query': str,
        }).then(
          (value) {
        value.data['results'].forEach((element) {
          searchMovies.add(
            MovieModel.fromJson(json: element),
          );
        });
        emit(SearchGetSearchMoviesSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(SearchGetSearchMoviesErrorState());
    });
  }
}
