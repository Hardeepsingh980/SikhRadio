part of 'player_bloc_bloc.dart';

abstract class PlayerBlocState extends Equatable {
  const PlayerBlocState();

  @override
  List<Object> get props => [];
}

class PlayerBlocInitial extends PlayerBlocState {}


class PlayerStateLoading extends PlayerBlocState {}

class PlayerStateLoaded extends PlayerBlocState {
  final RadioObject radio;
  final bool isPlaying; 

  PlayerStateLoaded({this.radio, this.isPlaying});
}

