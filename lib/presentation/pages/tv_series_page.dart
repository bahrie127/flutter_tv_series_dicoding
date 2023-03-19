import 'package:ditonton/presentation/bloc/tv_series_airing/tv_series_airing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/airing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';

import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'about_page.dart';
import 'home_movie_page.dart';
import 'search_page.dart';
import 'watchlist_movies_page.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/series';
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();

    context.read<TvSeriesAiringBloc>().add(TvSeriesAiringGetEvent());
    context.read<TvSeriesPopularBloc>().add(TvSeriesPopularGetEvent());
    context.read<TvSeriesTopRatedBloc>().add(TvSeriesTopRatedGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Saiful Bahri'),
              accountEmail: Text('saiful.bahri.tl@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.ROUTE_NAME,
                arguments: false,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, AiringTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesAiringBloc, TvSeriesAiringState>(
                builder: (context, state) {
                  if (state is TvSeriesAiringLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TvSeriesAiringLoaded) {
                    return TvSeriesList(state.tvSeriesList);
                  }

                  if (state is TvSeriesAiringError) {
                    return Text('Failed');
                  }

                  return Text('no data');
                },
              ),

              SubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              // tv series popular
              BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
                builder: (context, state) {
                  if (state is TvSeriesPopularLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TvSeriesPopularLoaded) {
                    return TvSeriesList(state.tvSeriesList);
                  }

                  if (state is TvSeriesPopularError) {
                    return Text('Failed');
                  }

                  return Text('no data');
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              //tv series top rated
              BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
                builder: (context, state) {
                  if (state is TvSeriesTopRatedLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TvSeriesTopRatedLoaded) {
                    return TvSeriesList(state.tvSeriesList);
                  }

                  if (state is TvSeriesTopRatedError) {
                    return Text('Failed');
                  }

                  return Text('no data');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
