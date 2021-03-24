import 'package:aiqap/feature/playing_now/bloc/audio_event.dart';
import 'package:aiqap/feature/playing_now/bloc/audio_state.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer audioPlayer;
  final AudioCache audioCache;
  AudioBloc(this.audioPlayer, this.audioCache) : super(StopAudioState());

  @override
  Stream<AudioState> mapEventToState(AudioEvent event) async* {
    if (event is PlayAudioEvent) {
      yield PlayingAudioState();
    }

    if (event is StopAudioEvent) {
      yield StopAudioState();
    }
  }
}
