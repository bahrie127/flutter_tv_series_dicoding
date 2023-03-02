import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    firstAirDate: '2000-11-11',
    backdropPath: '/img_path.jpg',
    genreIds: [
      1,
      2,
    ],
    id: 123,
    name: 'movie_title',
    overview: 'lorem ipsum 123',
    popularity: 144,
    posterPath: '/poster_path.jpg',
    voteAverage: 9.5,
    voteCount: 123,
    originCountry: ['ID'],
    originalLanguage: 'id',
    originalName: 'movie_title',
  );

  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_popular.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/img_path.jpg",
            "first_air_date": "2000-11-11",
            "genre_ids": [1, 2],
            "id": 123,
            "name": "movie_title",
            "origin_country": ["ID"],
            "original_language": "id",
            "original_name": "movie_title",
            "overview": "lorem ipsum 123",
            "popularity": 144,
            "poster_path": "/poster_path.jpg",
            "vote_average": 9.5,
            "vote_count": 123
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
