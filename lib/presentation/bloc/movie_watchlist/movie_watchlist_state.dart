part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;
  MovieWatchlistError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class MovieWatchlistAddSuccess extends MovieWatchlistState {
  final String message;
  MovieWatchlistAddSuccess({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class MovieWatchlistLoaded extends MovieWatchlistState {
  final List<Movie> movies;
  MovieWatchlistLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
