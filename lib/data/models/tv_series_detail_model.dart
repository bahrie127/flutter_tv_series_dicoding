import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailModel extends Equatable {
  final int id;
  final String name;
  final List<GenreModel> genres;
  final String posterPath;
  final double voteAverage;
  final String overview;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  TvSeriesDetailModel({
    required this.id,
    required this.name,
    required this.genres,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
  });

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailModel(
        id: json['id'],
        name: json['name'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'],
        overview: json['overview'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
      );

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      id: this.id,
      name: this.name,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      overview: this.overview,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        genres,
        posterPath,
        voteAverage,
        overview,
        numberOfEpisodes,
        numberOfSeasons
      ];
}