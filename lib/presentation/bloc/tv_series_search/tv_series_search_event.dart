part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesSearchQueryEvent extends TvSeriesSearchEvent {
  final String query;
  TvSeriesSearchQueryEvent({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
