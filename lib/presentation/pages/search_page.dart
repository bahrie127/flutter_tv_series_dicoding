import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';

import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  final bool isMovie;
  SearchPage({required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search ${isMovie ? 'Movie' : 'TV Series'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                isMovie
                    ? context
                        .read<MovieSearchBloc>()
                        .add(MovieSearchQueryEvent(query: query))
                    : context
                        .read<TvSeriesSearchBloc>()
                        .add(TvSeriesSearchQueryEvent(query: query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isMovie
                ? BlocBuilder<MovieSearchBloc, MovieSearchState>(
                    builder: (context, state) {
                      if (state is MovieSearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is MovieSearchLoaded) {
                        final result = state.movies;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      }
                      if (state is MovieSearchError) {
                        return Center(
                          child: Text('error'),
                        );
                      }
                      return Expanded(
                        child: Container(),
                      );
                    },
                  )
                : BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
                    builder: (context, state) {
                      if (state is TvSeriesSearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is TvSeriesSearchLoaded) {
                        final result = state.tvSeriesList;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return TvSeriesCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
