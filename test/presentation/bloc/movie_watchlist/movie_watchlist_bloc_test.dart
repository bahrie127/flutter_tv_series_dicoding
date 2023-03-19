import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, SaveWatchlist, RemoveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      mockGetWatchlistMovies,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });

  group(
    "Get Movie Watchlist",
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "Testing emit [Loading, Loaded] when responded successfully",
        build: () {
          when(
            mockGetWatchlistMovies.execute(),
          ).thenAnswer((_) async => Right(testMovieList));

          return movieWatchlistBloc;
        },
        act: (MovieWatchlistBloc bloc) => bloc.add(MovieWatchlistGetEvent()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistLoaded(movies: testMovieList),
        ],
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "Testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockGetWatchlistMovies.execute(),
          ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

          return movieWatchlistBloc;
        },
        act: (MovieWatchlistBloc bloc) => bloc.add(MovieWatchlistGetEvent()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );

  group(
    "Save Movie to Watchlist",
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "testing emit [Loading, HasData] when responded successfully",
        build: () {
          when(
            mockSaveWatchlist.execute(testMovieDetail),
          ).thenAnswer((_) async => Right('Added to Watchlist'));

          return movieWatchlistBloc;
        },
        act: (MovieWatchlistBloc bloc) =>
            bloc.add(MovieWatchlistAddEvent(movieDetail: testMovieDetail)),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistAddSuccess(message: 'Added to Watchlist'),
        ],
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockSaveWatchlist.execute(testMovieDetail),
          ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

          return movieWatchlistBloc;
        },
        act: (MovieWatchlistBloc bloc) =>
            bloc.add(MovieWatchlistAddEvent(movieDetail: testMovieDetail)),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );

  group(
    "Remove Movie to Watchlist",
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "testing emit [Loading, HasData] when responded successfully",
        build: () {
          when(
            mockRemoveWatchlist.execute(testMovieDetail),
          ).thenAnswer((_) async => Right('Removed from Watchlist'));

          return movieWatchlistBloc;
        },
        act: (MovieWatchlistBloc bloc) =>
            bloc.add(MovieWatchlistRemoveEvent(movieDetail: testMovieDetail)),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistAddSuccess(message: 'Removed from Watchlist'),
        ],
      );

      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockRemoveWatchlist.execute(testMovieDetail),
          ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

          return movieWatchlistBloc;
        },
        act: (MovieWatchlistBloc bloc) =>
            bloc.add(MovieWatchlistRemoveEvent(movieDetail: testMovieDetail)),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );
}
