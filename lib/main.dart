import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/const/themes.dart';
import 'package:movie_app/logic/services/bloc/app_layout/app_layout_bloc.dart';
import 'package:movie_app/logic/services/bloc/bloc_observer.dart';
import 'package:movie_app/logic/services/bloc/favorites/favorites_cubit.dart';
import 'package:movie_app/logic/services/bloc/home/home_states.dart';
import 'package:movie_app/logic/services/bloc/search/search_bloc.dart';
import 'package:movie_app/logic/services/cache_helper.dart';
import 'package:movie_app/logic/services/dio_helper.dart';
import 'package:movie_app/presentation/router/app_router.dart';
import 'logic/services/bloc/actors/actors_cubit.dart';
import 'logic/services/bloc/home/home_bloc.dart';
import 'presentation/screens/app_layout.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  AppRouter appRouter = AppRouter();
  runApp(
    MyApp(
      isDark: isDark,
      appRouter: appRouter,
    ),
  );
}

class MyApp extends StatelessWidget {
  final isDark;
  final AppRouter appRouter;

  const MyApp({super.key, this.isDark, required this.appRouter});

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
            ..getUpComingMovies()
            ..getTopRatedMovies()
            ..getPopularMovies(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
        BlocProvider<ActorsCubit>(
          create: (context) => ActorsCubit()..getActors(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit()..getFavorites(),
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
            home: EasySplashScreen(
              showLoader: true,
              loaderColor: cubit.isDark ? kWhiteColor : kDarkColor,
              logo: Image.asset(
                'assets/images/netflix-logo-png-2562.png',
              ),
              logoWidth: 100,
              title: Text('Bilal Arab'),
              backgroundColor: cubit.isDark ? kDarkColor : kWhiteColor,
              durationInSeconds: 5,
              navigator: const AppLayout(),
            ),
          );
        },
      ),
    );
  }
}
