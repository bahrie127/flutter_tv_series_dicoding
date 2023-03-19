part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object> get props => [];
}

class TvSeriesSearchInitial extends TvSeriesSearchState {}

class TvSeriesSearchLoading extends TvSeriesSearchState {}

class TvSeriesSearchError extends TvSeriesSearchState {
  final String message;
  TvSeriesSearchError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class TvSeriesSearchLoaded extends TvSeriesSearchState {
  final List<TvSeries> tvSeriesList;
  TvSeriesSearchLoaded({
    required this.tvSeriesList,
  });

  @override
  List<Object> get props => [tvSeriesList];
}
