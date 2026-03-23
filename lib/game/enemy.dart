import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../utils/constants.dart';

class EnemyComponent extends SpriteComponent {
  EnemyComponent({
    required Sprite sprite,
    required this.type,
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
          anchor: Anchor.topLeft,
        );

  final EnemyType type;
  final Vector2 _start;
  final Vector2 _end;
  final double speed;
  double _progress = 0;
  int _direction = 1;

  Rect get worldRect => Rect.fromLTWH(position.x, position.y, size.x, size.y);

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
    final distance = _start.distanceTo(_end).clamp(1, double.infinity);
    _progress += (_direction * speed * dt) / distance;
    if (_progress >= 1) {
      _progress = 1;
      _direction = -1;
    } else if (_progress <= 0) {
      _progress = 0;
      _direction = 1;
    }
    position.setValues(
      _start.x + (_end.x - _start.x) * _progress,
      _start.y + (_end.y - _start.y) * _progress,
    );
    if (type == EnemyType.rolling) {
      angle += dt * 4 * _direction;
    } else {
      scale.x = _direction == 1 ? 1 : -1;
      scale.y = 1 + math.sin(_progress * math.pi * 2) * 0.04;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final center = Offset(size.x / 2, size.y / 2);
    final body = Paint()..color = type == EnemyType.rolling ? const Color(0xFF4856BA) : const Color(0xFF6A4C93);
    final outline = Paint()
      ..color = const Color(0xFFD7E9FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, size.x / 2 - 2, body);
    canvas.drawCircle(center, size.x / 2 - 2, outline);
    final eye = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(Offset(size.x * 0.35, size.y * 0.36), 2.5, eye);
    canvas.drawCircle(Offset(size.x * 0.65, size.y * 0.36), 2.5, eye);
  }
}
