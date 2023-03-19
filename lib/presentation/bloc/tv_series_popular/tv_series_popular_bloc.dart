import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';

import '../../../domain/entities/tv_series.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries usecases;
  TvSeriesPopularBloc(
    this.usecases,
  ) : super(TvSeriesPopularInitial()) {
    on<TvSeriesPopularGetEvent>((event, emit) async {
      emit(TvSeriesPopularLoading());
      final result = await usecases.execute();
      result.fold(
        (l) => emit(TvSeriesPopularError(message: l.message)),
        (r) => emit(TvSeriesPopularLoaded(tvSeriesList: r)),
      );
    });
  }
}
