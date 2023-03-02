import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
  });

  late TvSeriesDetail _series;
  TvSeriesDetail get series => _series;

  RequestState _seriesState = RequestState.Empty;
  RequestState get seriesState => _seriesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesDetail(int id) async {
    _seriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    detailResult.fold(
      (failure) {
        _seriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _series = tvSeries;
        _seriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
