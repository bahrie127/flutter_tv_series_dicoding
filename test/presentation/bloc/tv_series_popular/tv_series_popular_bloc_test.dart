import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late TvSeriesPopularBloc tvSeriesPopularBloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesPopularBloc = TvSeriesPopularBloc(mockGetPopularTvSeries);
  });

  final tTvSeries = TvSeries(
    firstAirDate: '321',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'fdsafds',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: ['id'],
    originalLanguage: 'id',
    originalName: 'turkturk,',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    "Testing emit [Loading, Loaded] when Get popular TV Series response is successfully",
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer((_) async => Right(tTvSeriesList));

      return tvSeriesPopularBloc;
    },
    act: (TvSeriesPopularBloc bloc) => bloc.add(TvSeriesPopularGetEvent()),
    expect: () => [
      TvSeriesPopularLoading(),
      TvSeriesPopularLoaded(tvSeriesList: tTvSeriesList),
    ],
  );

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    "Testing emit [Loading, Error] when Get popular TV Series response is unsuccessful",
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return tvSeriesPopularBloc;
    },
    act: (TvSeriesPopularBloc bloc) => bloc.add(TvSeriesPopularGetEvent()),
    expect: () => [
      TvSeriesPopularLoading(),
      TvSeriesPopularError(message: 'Server Failure'),
    ],
  );
}
