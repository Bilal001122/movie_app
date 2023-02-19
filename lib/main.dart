import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/themes.dart';
import 'package:movie_app/screens/app_layout.dart';
import 'package:movie_app/services/bloc/bloc_observer.dart';
import 'package:movie_app/services/bloc/cubit.dart';
import 'package:movie_app/services/bloc/states.dart';
import 'package:movie_app/services/cache_helper.dart';

import 'services/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final isDark;

  const MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        AppCubit cubit = AppCubit();
        cubit.changeModeTheme(fromShared: isDark);
        cubit.getTopRatedMovies();
        cubit.getPopularMovies();
        cubit.getUpComingMovies();
        return cubit;
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Themes.kLightTheme,
            darkTheme: Themes.kDarkTheme,
            themeMode: appCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const AppLayout(),
          );
        },
      ),
    );
  }
}
