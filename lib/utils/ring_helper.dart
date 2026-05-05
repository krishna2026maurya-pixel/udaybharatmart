import 'package:audioplayers/audioplayers.dart';

class RingHelper {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playRing() async {
    await _player.play(AssetSource("laworder_svu.mp3"));
  }

  static Future<void> stopRing() async {
    await _player.stop();
  }
}
