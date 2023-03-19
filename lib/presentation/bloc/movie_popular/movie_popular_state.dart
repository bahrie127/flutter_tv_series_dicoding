part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularInitial extends MoviePopularState {}

class MoviePopularLoading extends MoviePopularState {}

class MoviePopularError extends MoviePopularState {
  final String message;
  MoviePopularError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class MoviePopularLoaded extends MoviePopularState {
  final List<Movie> movies;
  MoviePopularLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
