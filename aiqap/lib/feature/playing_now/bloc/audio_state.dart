import 'package:equatable/equatable.dart';

abstract class AudioState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayingAudioState extends AudioState {}

class PauseAudioState extends AudioState {}

class StopAudioState extends AudioState {}

class LoadAudioState extends AudioState {}
