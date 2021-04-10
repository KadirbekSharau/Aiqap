import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioProvider extends ChangeNotifier {
  Book currentBook;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration;
  Duration position;
  String playerState = "STOP";

  AudioProvider() {
    initialize();
  }

  void initialize() {
    audioPlayer.onDurationChanged.listen((event) {
      totalDuration = event;
      notifyListeners();
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      position = event;
      notifyListeners();
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      switch (event) {
        case AudioPlayerState.COMPLETED:
          playerState = "COMPLETE";
          break;
        case AudioPlayerState.PAUSED:
          playerState = "PAUSE";
          break;
        case AudioPlayerState.PLAYING:
          playerState = "PLAY";
          break;
        default:
          playerState = "STOP";
          break;
      }
      notifyListeners();
    });
  }

  void initBook(Book book) {
    if (currentBook == null) {
      currentBook = book;
      audioPlayer.dispose();
      audioPlayer = AudioPlayer();
      initialize();
    } else {
      if (currentBook.audio == book.audio) return;
      currentBook = book;
      audioPlayer.dispose();
      audioPlayer = AudioPlayer();
      initialize();
    }
    stopAudio();
  }

  void playAudio() {
    print("AUDIO IS ${currentBook.audio}");
    if (currentBook.audio != null) {
      print("PLAYING");
      audioPlayer.play(currentBook.audio, isLocal: true);
    }
  }

  void pauseAudio() {
    audioPlayer.pause();
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  void seek(Duration newPosition) {
    try {
      audioPlayer.seek(newPosition);
    } catch (e) {
      print("SEEKING ISSUE $e");
    }
  }

  void fastForward() {
    audioPlayer.seek(Duration(seconds: position.inSeconds + 10));
  }

  void fastBack() {
    if (position.inSeconds - 10 < 0) {
      audioPlayer.seek(Duration(seconds: 0));
    } else {
      audioPlayer.seek(Duration(seconds: position.inSeconds - 10));
    }
  }
}
