import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/services/bloc/actors/actors_state.dart';
import 'package:movie_app/logic/services/dio_helper.dart';
import '../../../models/actor_model.dart';

class ActorsCubit extends Cubit<ActorsState> {
  ActorsCubit() : super(ActorsInitial());

  static ActorsCubit get(context) => BlocProvider.of(context);

  List<ActorModel> actors = [];

  void getActors() {
    DioHelper.getData(
            url: '/person/popular?api_key=5eef0526cc051ce2676063f75e029825',
            query: null)
        .then(
      (value) {
        value.data['results'].forEach((element) {
          actors.add(
            ActorModel.fromJson(json: element),
          );
        });
        emit(ActorsGetSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(ActorsGetErrorState());
    });
  }
}
