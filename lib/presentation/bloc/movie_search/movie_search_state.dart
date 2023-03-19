part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
  
  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchError extends MovieSearchState {
  final String message;
  MovieSearchError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;
  MovieSearchLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}