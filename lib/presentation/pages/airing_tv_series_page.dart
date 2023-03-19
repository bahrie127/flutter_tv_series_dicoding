import 'package:ditonton/presentation/bloc/tv_series_airing/tv_series_airing_bloc.dart';

import 'package:ditonton/presentation/widgets/tv_series_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-series';

  @override
  _AiringSeriesPageState createState() => _AiringSeriesPageState();
}

class _AiringSeriesPageState extends State<AiringTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesAiringBloc>().add(TvSeriesAiringGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesAiringBloc, TvSeriesAiringState>(
          builder: (context, state) {
            if (state is TvSeriesAiringLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TvSeriesAiringLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.tvSeriesList[index];
                  return TvSeriesCard(series);
                },
                itemCount: state.tvSeriesList.length,
              );
            }
            if (state is TvSeriesAiringError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }

            return Center(
              key: Key('error_message'),
              child: Text('no data'),
            );
          },
        ),
      ),
    );
  }
}
