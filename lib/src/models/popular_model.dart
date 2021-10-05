// To parse this JSON data, do
//
//     final popularMoviesModel = popularMoviesModelFromJson(jsonString);

import 'dart:convert';

PopularMoviesModel popularMoviesModelFromJson(String str) => PopularMoviesModel.fromJson(json.decode(str));

//String popularMoviesModelToJson(PopularMoviesModel data) => json.encode(data.toJson());

class PopularMoviesModel {
    PopularMoviesModel({
        
        this.backdropPath,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,        
        this.voteAverage,
        this.voteCount,
    });    
    String? backdropPath;    
    int? id;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    DateTime? releaseDate;
    String? title;    
    int? voteAverage;
    int? voteCount;

    factory PopularMoviesModel.fromJson(Map<String, dynamic> json) => PopularMoviesModel(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
    );

    // Map<String, dynamic> toJson() => {
    //     "backdrop_path": backdropPath,
    //     "id": id,
    //     "original_language": originalLanguage,
    //     "original_title": originalTitle,
    //     "overview": overview,
    //     "popularity": popularity,
    //     "poster_path": posterPath,
    //     "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    //     "title": title,
    //     "vote_average": voteAverage,
    //     "vote_count": voteCount,
    // };
}
