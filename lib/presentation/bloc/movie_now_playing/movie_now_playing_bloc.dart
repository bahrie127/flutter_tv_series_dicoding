import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies usecases;

  MovieNowPlayingBloc(
    this.usecases,
  ) : super(MovieNowPlayingInitial()) {
    on<MovieNowPlayingGetEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await usecases.execute();
      result.fold(
        (l) => emit(MovieNowPlayingError(message: l.message)),
        (r) => emit(MovieNowPlayingLoaded(movies: r)),
      );
    });
  }
}
