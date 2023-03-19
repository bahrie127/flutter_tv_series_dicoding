import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    "Testing emit [Loading, Loaded] when Get Top Rated Movie response is successfully",
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer((_) async => Right(tMovieList));

      return movieTopRatedBloc;
    },
    act: (MovieTopRatedBloc bloc) => bloc.add(MovieTopRatedGetEvent()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedLoaded(movies: tMovieList),
    ],
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    "Testing emit [Loading, Error] when Get Top Rated Movie response is unsuccessful",
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieTopRatedBloc;
    },
    act: (MovieTopRatedBloc bloc) => bloc.add(MovieTopRatedGetEvent()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedError(message: 'Server Failure'),
    ],
  );
}
