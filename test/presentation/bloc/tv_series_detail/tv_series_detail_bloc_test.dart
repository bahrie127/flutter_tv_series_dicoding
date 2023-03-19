import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks(
    [GetTvSeriesDetail, GetTvSeriesRecommendations, GetTvSeriesWatchListStatus])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetTvSeriesWatchListStatus mockGetTvSeriesWatchListStatus;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetTvSeriesWatchListStatus = MockGetTvSeriesWatchListStatus();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      mockGetTvSeriesDetail,
      mockGetTvSeriesRecommendations,
      mockGetTvSeriesWatchListStatus,
    );
  });

  final tId = 1;

  final testTvSeriesDetail = TvSeriesDetail(
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: "Stranger Things",
    numberOfEpisodes: 34,
    numberOfSeasons: 4,
    overview: "Stranger Things",
    posterPath: "/49WJfeN0moxb9IPfGn8AIqMGskD.jpg",
    voteAverage: 8.6,
  );

  final testTvSeries = TvSeries(
    name: "fdsfas",
    firstAirDate: "123",
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    originCountry: ['213', '33'],
    originalLanguage: "ID",
    originalName: "fdfasda",
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testTvSeriesList = [testTvSeries];

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    "Testing emit [Loading, Loaded] when TV Series Detail response is successfully",
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesDetail));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesList));
      when(
        mockGetTvSeriesWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return tvSeriesDetailBloc;
    },
    act: (TvSeriesDetailBloc bloc) => bloc.add(TvSeriesDetailGetEvent(id: tId)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailLoaded(
        detail: testTvSeriesDetail,
        recommendations: testTvSeriesList,
        isWatchlist: true,
      ),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    "Testing emit [Loading, Error] when TV Series Detail response is unsuccessful",
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesList));
      when(
        mockGetTvSeriesWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return tvSeriesDetailBloc;
    },
    act: (TvSeriesDetailBloc bloc) => bloc.add(TvSeriesDetailGetEvent(id: tId)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailError('Server Failure'),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    "testing emit [Loading, Error] when TV Series Recommendations response is unsuccessful",
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesDetail));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(
        mockGetTvSeriesWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return tvSeriesDetailBloc;
    },
    act: (TvSeriesDetailBloc bloc) => bloc.add(TvSeriesDetailGetEvent(id: tId)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailError('Server Failure'),
    ],
  );
}
