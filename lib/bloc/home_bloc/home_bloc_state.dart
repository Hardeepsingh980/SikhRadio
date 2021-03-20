part of 'home_bloc_bloc.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeStateInitial extends HomeBlocState {}

class HomeStateLoading extends HomeBlocState {}

class HomeStateError extends HomeBlocState {}

class HomeStateLoaded extends HomeBlocState {
  final List<RadioObject> radioList;
  final List<RadioObject> gRadioList;

  HomeStateLoaded({this.radioList, this.gRadioList});
}
