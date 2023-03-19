part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class MovieWatchlistGetEvent extends MovieWatchlistEvent {}

class MovieWatchlistAddEvent extends MovieWatchlistEvent {
  final MovieDetail movieDetail;
  MovieWatchlistAddEvent({
    required this.movieDetail,
  });

  @override
  List<Object> get props => [movieDetail];
}

class MovieWatchlistRemoveEvent extends MovieWatchlistEvent {
  final MovieDetail movieDetail;
  MovieWatchlistRemoveEvent({
    required this.movieDetail,
  });
  @override
  List<Object> get props => [movieDetail];
}
