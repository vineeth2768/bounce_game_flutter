import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'platform.dart';

class MovingPlatformComponent extends SolidSurface {
  MovingPlatformComponent({
    required Sprite sprite,
    required Vector2 start,
    required Vector2 end,
    required Vector2 size,
    required this.speed,
  })  : _start = start,
        _end = end,
        super(
          sprite: sprite,
          position: start.clone(),
          size: size,
        );

  final Vector2 _start;
  final Vector2 _end;
  final double speed;
  double _progress = 0;
  int _direction = 1;
  final Vector2 _frameDelta = Vector2.zero();

  @override
  Vector2 get frameDelta => _frameDelta;

  @override
  Future<void> onLoad() async {
    await add(
      RectangleHitbox()
        ..collisionType = CollisionType.passive,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    final old = position.clone();
    final distance = _start.distanceTo(_end).clamp(1, double.infinity);
    _progress += (_direction * speed * dt) / distance;
    if (_progress >= 1) {
      _progress = 1;
      _direction = -1;
    } else if (_progress <= 0) {
      _progress = 0;
      _direction = 1;
    }
    position = Vector2(
      _start.x + (_end.x - _start.x) * _progress,
      _start.y + (_end.y - _start.y) * _progress,
    );
    _frameDelta.setFrom(position - old);
    angle = math.sin(_progress * math.pi) * 0.01;
  }
}
