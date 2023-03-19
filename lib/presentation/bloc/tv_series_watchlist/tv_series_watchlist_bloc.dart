import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';

import '../../../domain/entities/tv_series.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;

  TvSeriesWatchlistBloc(
    this.getWatchlistTvSeries,
    this.removeTvSeriesWatchlist,
    this.saveTvSeriesWatchlist,
  ) : super(TvSeriesWatchlistInitial()) {
    on<TvSeriesWatchlistGetEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoading());
      final result = await getWatchlistTvSeries.execute();
      result.fold(
        (l) => emit(TvSeriesWatchlistError(message: l.message)),
        (r) => emit(TvSeriesWatchlistLoaded(tvSeriesList: r)),
      );
    });

    on<TvSeriesWatchlistAddEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoading());
      final result = await saveTvSeriesWatchlist.execute(event.detail);
      result.fold(
        (l) => emit(TvSeriesWatchlistError(message: l.message)),
        (r) => emit(TvSeriesWatchlistSuccess(message: r)),
      );
    });

    on<TvSeriesWatchlistRemoveEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoading());
      final result = await removeTvSeriesWatchlist.execute(event.detail);
      result.fold(
        (l) => emit(TvSeriesWatchlistError(message: l.message)),
        (r) => emit(TvSeriesWatchlistSuccess(message: r)),
      );
    });
  }
}
