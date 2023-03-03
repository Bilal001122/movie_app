import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/services/bloc/app_layout/app_layout_states.dart';
import 'package:movie_app/logic/services/cache_helper.dart';
import 'package:movie_app/presentation/screens/home_screen.dart';
import 'package:movie_app/presentation/screens/search_screen.dart';

class AppLayoutCubit extends Cubit<AppLayoutStates>{
  AppLayoutCubit() : super(AppLayoutInitialState());

  static AppLayoutCubit get(BuildContext context) => BlocProvider.of(context);



  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const Text(
      'Fav',
    ),
    const Text(
      'Profile',
    ),
  ];



  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppLayoutBottomNavBarChangedState());
  }
}