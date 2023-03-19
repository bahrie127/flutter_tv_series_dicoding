part of 'tv_series_popular_bloc.dart';

abstract class TvSeriesPopularEvent extends Equatable {
  const TvSeriesPopularEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesPopularGetEvent extends TvSeriesPopularEvent {}
