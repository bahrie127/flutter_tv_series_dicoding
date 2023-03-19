part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailGetEvent extends MovieDetailEvent {
  final int id;
  MovieDetailGetEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
