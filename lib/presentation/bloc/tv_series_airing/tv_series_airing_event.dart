part of 'tv_series_airing_bloc.dart';

abstract class TvSeriesAiringEvent extends Equatable {
  const TvSeriesAiringEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesAiringGetEvent extends TvSeriesAiringEvent{}
