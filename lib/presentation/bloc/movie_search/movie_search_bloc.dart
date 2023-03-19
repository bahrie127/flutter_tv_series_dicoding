import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/usecases/search_movies.dart';

import '../../../domain/entities/movie.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies usecases;
  MovieSearchBloc(
    this.usecases,
  ) : super(MovieSearchInitial()) {
    on<MovieSearchQueryEvent>((event, emit) async {
      emit(MovieSearchLoading());
      final result = await usecases.execute(event.query);
      result.fold(
        (l) => emit(MovieSearchError(message: l.message)),
        (r) => emit(MovieSearchLoaded(movies: r)),
      );
    });
  }
}
