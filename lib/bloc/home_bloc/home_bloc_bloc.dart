import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sikh_radio/data/data.dart';
import 'package:sikh_radio/data/model.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeStateInitial());

  DataApi dataApi = DataApi();

  @override
  Stream<HomeBlocState> mapEventToState(
    HomeBlocEvent event,
  ) async* {
    if (event is HomeEventLoading) {
      yield* _mapLoadRadioState(event);
    }
  }

  Stream<HomeBlocState> _mapLoadRadioState(HomeEventLoading event) async* {
    try {
      yield HomeStateLoading();
      List<RadioObject> radioList = await dataApi.getRadioList();
      List<RadioObject> gRadioList = await dataApi.getGRadioList();
      yield HomeStateLoaded(radioList: radioList, gRadioList: gRadioList);
    } catch (e) {
      yield HomeStateError();
    }
  }
}
