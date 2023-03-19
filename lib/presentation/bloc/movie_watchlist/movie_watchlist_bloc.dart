import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';

import '../../../domain/entities/movie.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;
  MovieWatchlistBloc(
    this.getWatchlistMovies,
    this.removeWatchlist,
    this.saveWatchlist,
  ) : super(MovieWatchlistInitial()) {
    on<MovieWatchlistGetEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (l) => emit(MovieWatchlistError(message: l.message)),
        (r) => emit(MovieWatchlistLoaded(movies: r)),
      );
    });

    on<MovieWatchlistAddEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await saveWatchlist.execute(event.movieDetail);
      result.fold(
        (l) => emit(MovieWatchlistError(message: l.message)),
        (r) => emit(MovieWatchlistAddSuccess(message: r)),
      );
    });

    on<MovieWatchlistRemoveEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await removeWatchlist.execute(event.movieDetail);
      result.fold(
        (l) => emit(MovieWatchlistError(message: l.message)),
        (r) => emit(MovieWatchlistAddSuccess(message: r)),
      );
    });
  }
}
