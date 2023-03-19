import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';

import '../../../domain/entities/movie.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies usecases;
  MovieTopRatedBloc(
    this.usecases,
  ) : super(MovieTopRatedInitial()) {
    on<MovieTopRatedGetEvent>((event, emit) async {
      emit(MovieTopRatedLoading());
      final result = await usecases.execute();
      result.fold(
        (l) => emit(MovieTopRatedError(message: l.message)),
        (r) => emit(MovieTopRatedLoaded(movies: r)),
      );
    });
  }
}
