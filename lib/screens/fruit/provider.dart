import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/socket/provider.dart';

class FruitStateProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  late AudioPlayer audioPlayer;
  late AudioPlayer winnerSoundPlayer;
  bool get isPlaying => _isPlaying;
  bool _isPlaying = false;
  List soundTrack = [
    'https://github.com/Sixtus6/myassets/raw/main/fruit.wav',
    'https://github.com/Sixtus6/myassets/raw/main/fruitsWin.wav'
  ];

  FruitStateProvider() {
    audioPlayer = AudioPlayer();
    initFruitState(0);
  }

  Future<void> initFruitState(val) async {
    await audioPlayer.setUrl(soundTrack[val]);
    print("playing  ${soundTrack[val]}");
  }

  Future<void> setSoundTrack(BuildContext context, val) async {
    SocketProvider socketInstances =
        Provider.of<SocketProvider>(context, listen: false);
    await audioPlayer.setUrl(soundTrack[socketInstances.counter == 49 ||
            socketInstances.counter == 48 ||
            socketInstances.counter == 47 ||
            socketInstances.counter == 46
        ? 1
        : 0]);
    bool changeSound = socketInstances.counter == 49 ||
            socketInstances.counter == 48 ||
            socketInstances.counter == 47 ||
            socketInstances.counter == 46
        ? true
        : false;
    print("setting player ${soundTrack[(changeSound || val) ? 1 : 0]}");
  }

  togglePlayPauseButton(bool, context) async {
    _isPlaying = bool;
    print([_isPlaying, bool]);

    notifyListeners();
  }

  // Future<void> togglePlayPause() async {
  //   if (isPlaying) {
  //     await _audioPlayer.pause();
  //   } else {
  //     await _audioPlayer.play();
  //   }
  //   notifyListeners();
  // }

  void increment() {
    _counter++;
    notifyListeners(); // Notify listeners about the change
  }

  bool pineapple = false;
  bool orange = false;
  bool banana = false;
  bool starwberry = false;

  void setCounter(counter) {
    _counter = counter;
    notifyListeners();
  }

  void setCurrentTab(
      {required bool pine,
      required bool orange,
      required bool banana,
      required bool straw}) {
    this.pineapple = pine;
    this.orange = orange;
    this.banana = banana;
    this.starwberry = straw;
    notifyListeners();
  }
}
