import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();
    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
      mockGetWatchlistTvSeries,
      mockRemoveTvSeriesWatchlist,
      mockSaveTvSeriesWatchlist,
    );
  });

  group(
    "Get TV Series Watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Loaded] when responded successfully",
        build: () {
          when(
            mockGetWatchlistTvSeries.execute(),
          ).thenAnswer((_) async => Right(testTvSeriesList));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistGetEvent()),
        expect: () => [
          TvSeriesWatchlistLoading(),
          TvSeriesWatchlistLoaded(tvSeriesList: testTvSeriesList),
        ],
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockGetWatchlistTvSeries.execute(),
          ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistGetEvent()),
        expect: () => [
          TvSeriesWatchlistLoading(),
          TvSeriesWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );

  group(
    "Save TV Series Watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "should emit [Loading, Loaded] when responded successfully",
        build: () {
          when(
            mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer((_) async => Right('Added to Watchlist'));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistAddEvent(detail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          TvSeriesWatchlistSuccess(message: 'Added to Watchlist'),
        ],
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistAddEvent(detail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          TvSeriesWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );

  group(
    "Remove TV Series Watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Loaded] when responded successfully",
        build: () {
          when(
            mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer((_) async => Right('Removed from Watchlist'));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistRemoveEvent(detail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          TvSeriesWatchlistSuccess(message: 'Removed from Watchlist'),
        ],
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistRemoveEvent(detail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          TvSeriesWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );
}
