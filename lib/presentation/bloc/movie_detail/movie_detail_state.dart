part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail detail;
  final List<Movie> recommendations;
  final bool isWatchlist;
  MovieDetailLoaded({
    required this.detail,
    required this.recommendations,
    required this.isWatchlist,
  });

  @override
  List<Object> get props => [detail, recommendations, isWatchlist];
}
