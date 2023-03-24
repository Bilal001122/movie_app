class ActorModel {

  late final String? profilePath;
  late final bool? adult;
  late final int? id;
  late final List<KnownFor>? knownFor;
  late final String? name;
  late final dynamic popularity;

  ActorModel.fromJson({required dynamic json}) {
    profilePath = 'https://image.tmdb.org/t/p/original${json['profile_path']}';
    adult = json['adult'];
    id = json['id'];
    if (json['known_for'] != null) {
      knownFor = [];
      json['known_for'].forEach((v) {
        knownFor!.add(KnownFor.fromJson(v));
      });
    }
    name = json['name'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_path'] = profilePath;
    map['adult'] = adult;
    map['id'] = id;
    if (knownFor != null) {
      map['known_for'] = knownFor!.map((v) => v.toJson()).toList();
    }
    map['name'] = name;
    map['popularity'] = popularity;
    return map;
  }
}

class KnownFor {
  late final String? posterPath;
  late final bool? adult;
  late final String? overview;
  late final String? releaseDate;
  late final String? originalTitle;
  late final List<int>? genreIds;
  late final int? id;
  late final String? mediaType;
  late final String? originalLanguage;
  late final String? title;
  late final String? backdropPath;
  late final double? popularity;
  late final dynamic voteCount;
  late final bool? video;
  late final String? name;
  late final String? originalName;
  late final dynamic voteAverage;

  KnownFor({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.originalTitle,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  KnownFor.fromJson(dynamic json) {
    name = json['name'];
    originalName = json['original_name'];
    posterPath = 'https://image.tmdb.org/t/p/original${json['poster_path']}';
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];
    title = json['title'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['poster_path'] = posterPath;
    map['adult'] = adult;
    map['overview'] = overview;
    map['release_date'] = releaseDate;
    map['original_title'] = originalTitle;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['media_type'] = mediaType;
    map['original_language'] = originalLanguage;
    map['title'] = title;
    map['backdrop_path'] = backdropPath;
    map['popularity'] = popularity;
    map['vote_count'] = voteCount;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    return map;
  }
}
