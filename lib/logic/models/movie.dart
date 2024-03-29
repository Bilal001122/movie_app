class MovieModel {
  late final dynamic id;
  late final String? title;
  late final dynamic originalLanguage;
  late final String? originalTitle;
  late final String? overview;
  late final dynamic posterPath;
  late final dynamic mediaType;
  late final dynamic releaseDate;
  late final dynamic voteAverage;
  late final String? name;
  late final String? originalName;
  late final dynamic firstAirDate;

  MovieModel({
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.releaseDate,
    required this.voteAverage,
    required this.name,
    required this.originalName,
    required this.firstAirDate,
  });

  MovieModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = 'https://image.tmdb.org/t/p/original${json['poster_path']}';
    mediaType = json['media_type'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
    name = json['name'];
    originalName = json['original_name'];
    firstAirDate = json['first_air_date'];
  }
}
