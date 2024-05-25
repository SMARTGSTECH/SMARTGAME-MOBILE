import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class CarStateProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  late AudioPlayer audioPlayer;

  bool get isPlaying => _isPlaying;
  bool _isPlaying = false;

  CarStateProvider() {
    audioPlayer = AudioPlayer();

    _initCarState();
  }

  Future<void> _initCarState() async {
    await audioPlayer.setUrl('https://github.com/Sixtus6/myassets/raw/main/car.wav');
  }

  togglePlayPauseButton(bool) async {
    _isPlaying = bool;
    print([_isPlaying, bool]);
  
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners(); 
  }

  bool green = false;
  bool red = false;
  bool yellow = false;
  bool blue = false;

  void setCounter(counter) {
    _counter = counter;
    notifyListeners();
  }

  void setCurrentTab(
      {required bool green,
      required bool red,
      required bool yellow,
      required bool blue}) {
    this.green = green;
    this.red = red;
    this.yellow = yellow;
    this.blue = blue;
    notifyListeners();
  }
}
