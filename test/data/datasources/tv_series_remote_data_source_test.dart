import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=6d37959d5d8ea4dd3aee259761d87076';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  String jsonString = '''
{
    "page": 1,
    "results": [
        {
            "backdrop_path": "/uDgy6hyPd82kOHh6I95FLtLnj6p.jpg",
            "first_air_date": "2023-01-15",
            "genre_ids": [
                18
            ],
            "id": 100088,
            "name": "The Last of Us",
            "origin_country": [
                "US"
            ],
            "original_language": "en",
            "original_name": "The Last of Us",
            "overview": "Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.",
            "popularity": 3617.715,
            "poster_path": "/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg",
            "vote_average": 8.8,
            "vote_count": 2688
        },
        {
            "backdrop_path": "/xgZ9AhvXqi9aSDWzCpoC9JAkLPY.jpg",
            "first_air_date": "2019-01-01",
            "genre_ids": [
                35
            ],
            "id": 85425,
            "name": "Dear Heirs",
            "origin_country": [
                "HU"
            ],
            "original_language": "hu",
            "original_name": "Drága örökösök",
            "overview": "Hungarian remake of the Bulgarian series about a disconnect family living together in order to get an inheritance.",
            "popularity": 3248.132,
            "poster_path": "/xDOUahrwEsgDlejXjZLc9lOljSx.jpg",
            "vote_average": 5.3,
            "vote_count": 7
        }
    ],
    "total_pages": 7306,
    "total_results": 146107
}
''';

  group('get Popular TV Series', () {
    final tTvSeriesList =
        TvSeriesResponse.fromJson(json.decode(jsonString)).tvSeriesList;

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_top_rated.json')))
        .tvSeriesList;

    test(
        'should return list of top rated TV Series when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, tTvSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Airing Today TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_airing_today.json')))
        .tvSeriesList;

    test(
        'should return list of Airing Today TV Series when response code is 200 ',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_airing_today.json'), 200));
      // act
      final result = await dataSource.getAiringTvSeries();
      // assert
      expect(result, tTvSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getAiringTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TV Series', () {
    final tSearchResult =
        TvSeriesResponse.fromJson(json.decode(jsonString)).tvSeriesList;
    final tQuery = 'Last';

    test('should search TV Series when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
