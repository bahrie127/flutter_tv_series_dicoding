import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/usecases/search_tv_series.dart';

import '../../../domain/entities/tv_series.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries usecases;
  TvSeriesSearchBloc(
    this.usecases,
  ) : super(TvSeriesSearchInitial()) {
    on<TvSeriesSearchQueryEvent>((event, emit) async {
      emit(TvSeriesSearchLoading());
      final result = await usecases.execute(event.query);
      result.fold(
        (l) => emit(TvSeriesSearchError(message: l.message)),
        (r) => emit(TvSeriesSearchLoaded(tvSeriesList: r)),
      );
    });
  }
}
