
import 'package:audioplayers/audioplayers.dart';
class AudioService {

  final AudioPlayer _player = AudioPlayer();
  
  /// Reproducir un archivo de audio desde la ruta
  Future<void> play(String path) async {
    await _player.play(DeviceFileSource(path));
  }

  /// Detener la reproducción
  Future<void> stop() async {
    await _player.stop();
  }
}
