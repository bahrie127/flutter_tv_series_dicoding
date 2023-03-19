part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedInitial extends MovieTopRatedState {}

class MovieTopRatedLoading extends MovieTopRatedState {}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;
  MovieTopRatedError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Movie> movies;
  MovieTopRatedLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
