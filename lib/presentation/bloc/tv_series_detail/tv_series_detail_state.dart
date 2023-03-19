part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();
  
  @override
  List<Object> get props => [];
}

class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail detail;
  final List<TvSeries> recommendations;
  final bool isWatchlist;
  TvSeriesDetailLoaded({
    required this.detail,
    required this.recommendations,
    required this.isWatchlist,
  });

  

  @override
  List<Object> get props => [detail, recommendations, isWatchlist];
}
