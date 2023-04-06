
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class GetFavoritesSuccess extends FavoritesState {}

class GetFavoritesError extends FavoritesState {}

class AddToFavoritesSuccess extends FavoritesState {}

class AddToFavoritesError extends FavoritesState {}

class RemoveFromFavoritesSuccess extends FavoritesState {}

class RemoveFromFavoritesError extends FavoritesState {}

class DeleteFromFavoritesSuccess extends FavoritesState {}

class DeleteFromFavoritesError extends FavoritesState {}

class ChangeColorSuccess extends FavoritesState {}

class ChangeColorError extends FavoritesState {}