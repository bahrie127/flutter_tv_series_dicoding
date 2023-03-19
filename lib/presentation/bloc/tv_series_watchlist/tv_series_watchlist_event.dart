part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistGetEvent extends TvSeriesWatchlistEvent {}

class TvSeriesWatchlistAddEvent extends TvSeriesWatchlistEvent {
  final TvSeriesDetail detail;
  TvSeriesWatchlistAddEvent({
    required this.detail,
  });

  @override
  List<Object> get props => [detail];
}

class TvSeriesWatchlistRemoveEvent extends TvSeriesWatchlistEvent {
  final TvSeriesDetail detail;
  TvSeriesWatchlistRemoveEvent({
    required this.detail,
  });
  @override
  List<Object> get props => [detail];
}
