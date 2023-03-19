part of 'tv_series_popular_bloc.dart';

abstract class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();
  
  @override
  List<Object> get props => [];
}

class TvSeriesPopularInitial extends TvSeriesPopularState {}

class TvSeriesPopularLoading extends TvSeriesPopularState {}

class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;
  TvSeriesPopularError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class TvSeriesPopularLoaded extends TvSeriesPopularState {
  final List<TvSeries> tvSeriesList;
  TvSeriesPopularLoaded({
    required this.tvSeriesList,
  });

  @override
  List<Object> get props => [tvSeriesList];
}