import 'package:equatable/equatable.dart';

abstract class AudioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayAudioEvent extends AudioEvent {}

class PauseAudioEvent extends AudioEvent {}

class StopAudioEvent extends AudioEvent {}
