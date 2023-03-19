part of 'tv_series_airing_bloc.dart';

abstract class TvSeriesAiringState extends Equatable {
  const TvSeriesAiringState();

  @override
  List<Object> get props => [];
}

class TvSeriesAiringInitial extends TvSeriesAiringState {}

class TvSeriesAiringLoading extends TvSeriesAiringState {}

class TvSeriesAiringError extends TvSeriesAiringState {
  final String message;
  TvSeriesAiringError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class TvSeriesAiringLoaded extends TvSeriesAiringState {
  final List<TvSeries> tvSeriesList;
  TvSeriesAiringLoaded({
    required this.tvSeriesList,
  });

  @override
  List<Object> get props => [tvSeriesList];
}
