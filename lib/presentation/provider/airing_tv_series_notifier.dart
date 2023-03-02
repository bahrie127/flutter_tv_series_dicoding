import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:flutter/foundation.dart';

class AiringTvSeriesNotifier extends ChangeNotifier {
  final GetAiringTvSeries getAiringTvSeries;

  AiringTvSeriesNotifier({required this.getAiringTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _series = [];
  List<TvSeries> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesData) {
        _series = tvSeriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
