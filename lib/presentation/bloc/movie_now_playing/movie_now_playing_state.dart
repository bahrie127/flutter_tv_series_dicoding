part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingInitial extends MovieNowPlayingState {}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;
  MovieNowPlayingError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> movies;
  MovieNowPlayingLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
