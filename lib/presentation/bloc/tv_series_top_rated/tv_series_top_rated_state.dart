part of 'tv_series_top_rated_bloc.dart';

abstract class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class TvSeriesTopRatedInitial extends TvSeriesTopRatedState {}

class TvSeriesTopRatedLoading extends TvSeriesTopRatedState {}

class TvSeriesTopRatedError extends TvSeriesTopRatedState {
  final String message;
  TvSeriesTopRatedError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class TvSeriesTopRatedLoaded extends TvSeriesTopRatedState {
  final List<TvSeries> tvSeriesList;
  TvSeriesTopRatedLoaded({
    required this.tvSeriesList,
  });

  @override
  List<Object> get props => [tvSeriesList];
}
