import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic/services/bloc/favorites/favorites_cubit.dart';
import 'package:movie_app/logic/services/bloc/favorites/favorites_state.dart';
import 'package:movie_app/presentation/shared/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(

      listener: (context, state) {
      },
      builder: (context, state) {
        FavoritesCubit favoritesCubit = FavoritesCubit.get(context);
        return favoritesCubit.favorites.isNotEmpty
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 12),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Dismissible(
                      onDismissed: (direction) {
                        favoritesCubit.deleteFromFavorites(favoritesCubit.favorites[index]);
                      },
                      key: UniqueKey(),
                      child: MovieWidgetForSearch(
                        movie: favoritesCubit.favorites[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: favoritesCubit.favorites.length,
                  ),
                ),
              )
            : const Center(
                child: Text(
                  'No Favorites Yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
      },
    );
  }
}
