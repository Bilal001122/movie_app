class MovieModel {
  late final dynamic id;
  late final dynamic title;
  late final dynamic originalLanguage;
  late final dynamic originalTitle;
  late final dynamic overview;
  late final dynamic posterPath;
  late final dynamic mediaType;
  late final dynamic releaseDate;
  late final dynamic voteAverage;
  late final dynamic name;
  late final dynamic originalName;
  late final dynamic firstAirDate;

  MovieModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = 'https://image.tmdb.org/t/p/original' + json['poster_path'];
    mediaType = json['media_type'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
    name = json['name'];
    originalName = json['original_name'];
    firstAirDate = json['first_air_date'];
  }
}
