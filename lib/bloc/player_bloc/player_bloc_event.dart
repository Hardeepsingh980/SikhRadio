part of 'player_bloc_bloc.dart';

abstract class PlayerBlocEvent extends Equatable {
  const PlayerBlocEvent();

  @override
  List<Object> get props => [];
}

class PlayerEventLoading extends PlayerBlocEvent {}

class PlayerEventPlay extends PlayerBlocEvent {}

class PlayerEventRadioChanged extends PlayerBlocEvent {
  final RadioObject radio;

  PlayerEventRadioChanged({this.radio});
}

class PlayerEventPause extends PlayerBlocEvent {}

class PlayerEventNext extends PlayerBlocEvent {}

class PlayerEventPrevious extends PlayerBlocEvent {}
