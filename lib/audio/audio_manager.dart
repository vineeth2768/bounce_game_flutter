import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

import '../utils/constants.dart';

class AudioManager {
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    FlameAudio.updatePrefix('assets/');
    _initialized = true;
  }

  Future<void> playJump() => _play(AssetPaths.jumpSound);
  Future<void> playRing() => _play(AssetPaths.ringSound);
  Future<void> playHit() => _play(AssetPaths.hitSound);
  Future<void> playLevelComplete() => _play(AssetPaths.levelCompleteSound);

  Future<void> playMusic() async {
    if (kIsWeb) {
      return;
    }
    try {
      await initialize();
      await FlameAudio.bgm.play(AssetPaths.music, volume: 0.3);
    } catch (_) {
      // Audio is optional in the placeholder asset setup.
    }
  }

  Future<void> stopMusic() async {
    try {
      await FlameAudio.bgm.stop();
    } catch (_) {
      // Ignore missing or unsupported audio playback.
    }
  }

  Future<void> _play(String path) async {
    try {
      await initialize();
      await FlameAudio.play(path, volume: 0.55);
    } catch (_) {
      // Ignore missing or unsupported audio playback.
    }
  }
}
