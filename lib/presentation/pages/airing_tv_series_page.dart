import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/airing_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AiringTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-series';

  @override
  _AiringSeriesPageState createState() => _AiringSeriesPageState();
}

class _AiringSeriesPageState extends State<AiringTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<AiringTvSeriesNotifier>(context, listen: false)
          .fetchAiringTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = data.series[index];
                  return TvSeriesCard(series);
                },
                itemCount: data.series.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
