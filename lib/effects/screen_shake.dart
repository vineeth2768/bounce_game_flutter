import 'dart:math' as math;

import 'package:flame/components.dart';

class ScreenShakeController {
  final math.Random _random = math.Random();
  double _timer = 0;
  double _intensity = 0;

  void shake({
    double duration = 0.2,
    double intensity = 10,
  }) {
    _timer = duration;
    _intensity = intensity;
  }

  void update(double dt) {
    if (_timer > 0) {
      _timer = math.max(0, _timer - dt);
    }
  }

  Vector2 sampleOffset() {
    if (_timer <= 0) {
      return Vector2.zero();
    }
    return Vector2(
      (_random.nextDouble() * 2 - 1) * _intensity,
      (_random.nextDouble() * 2 - 1) * _intensity * 0.6,
    );
  }
}
