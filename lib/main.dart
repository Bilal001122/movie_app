import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/themes.dart';
import 'package:movie_app/logic/services/bloc/app_layout/app_layout_bloc.dart';
import 'package:movie_app/logic/services/bloc/bloc_observer.dart';
import 'package:movie_app/logic/services/bloc/home/home_states.dart';
import 'package:movie_app/logic/services/bloc/search/search_bloc.dart';
import 'package:movie_app/logic/services/cache_helper.dart';
import 'package:movie_app/logic/services/dio_helper.dart';
import 'package:movie_app/presentation/router/app_router.dart';
import 'logic/services/bloc/home/home_bloc.dart';
import 'presentation/screens/app_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  AppRouter appRouter = AppRouter();
  runApp(MyApp(
    isDark: isDark,
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  final isDark;
  final AppRouter appRouter;
  const MyApp({super.key, this.isDark , required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppLayoutCubit>(
          create: (context) => AppLayoutCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()
            ..changeModeTheme(fromShared: isDark)
            ..getTopRatedMovies()
            ..getUpComingMovies()
            ..getPopularMovies(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Themes.kLightTheme,
            darkTheme: Themes.kDarkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: appRouter.onGenerateRoute,
            home: const AppLayout(),
          );
        },
      ),
    );
  }
}
