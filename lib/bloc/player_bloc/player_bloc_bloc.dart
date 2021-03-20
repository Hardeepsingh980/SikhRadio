import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sikh_radio/data/data.dart';
import 'package:sikh_radio/data/model.dart';

part 'player_bloc_event.dart';
part 'player_bloc_state.dart';

class PlayerBlocBloc extends Bloc<PlayerBlocEvent, PlayerBlocState> {
  PlayerBlocBloc() : super(PlayerBlocInitial());

  DataApi dataApi = DataApi();

  final player = AudioPlayer();

  List<RadioObject> radioList = [];

  RadioObject curPlaying;

  @override
  Stream<PlayerBlocState> mapEventToState(
    PlayerBlocEvent event,
  ) async* {
    if (event is PlayerEventLoading) {
      yield PlayerStateLoading();
      curPlaying = await dataApi.getInitialRadio();
      player.setUrl(curPlaying.radioUrl);
      radioList = await dataApi.getRadioList();
      yield PlayerStateLoaded(radio: curPlaying, isPlaying: false);
    } else if (event is PlayerEventPlay) {
      yield PlayerStateLoading();
      player.play();
      MediaNotification.showNotification(
          title: curPlaying.name,
          author: curPlaying.type == 0 ? curPlaying.desc : "Playing Live",
          isPlaying: true);
      yield PlayerStateLoaded(radio: curPlaying, isPlaying: true);
    } else if (event is PlayerEventPause) {
      yield PlayerStateLoading();
      player.pause();
      MediaNotification.showNotification(
          title: curPlaying.name,
          author: curPlaying.type == 0 ? curPlaying.desc : "Playing Live",
          isPlaying: false);
      yield PlayerStateLoaded(radio: curPlaying, isPlaying: false);
    } else if (event is PlayerEventRadioChanged) {
      yield PlayerStateLoading();
      dataApi.addHistory(event.radio);
      player.setUrl(event.radio.radioUrl);
      player.play();
      curPlaying = event.radio;
      MediaNotification.showNotification(
          title: curPlaying.name,
          author: curPlaying.type == 0 ? curPlaying.desc : "Playing Live",
          isPlaying: true);
      yield PlayerStateLoaded(radio: curPlaying, isPlaying: true);
    } else if (event is PlayerEventNext) {
      yield PlayerStateLoading();
      RadioObject randomRadio = (radioList.toList()..shuffle()).first;
      dataApi.addHistory(randomRadio);
      player.setUrl(randomRadio.radioUrl);
      player.play();
      curPlaying = randomRadio;
      MediaNotification.showNotification(
          title: curPlaying.name,
          author: curPlaying.type == 0 ? curPlaying.desc : "Playing Live",
          isPlaying: true);
      yield PlayerStateLoaded(radio: curPlaying, isPlaying: true);
    }
  }
}
