import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class RingComponent extends SpriteComponent {
  RingComponent({
    required Sprite sprite,
    required Vector2 position,
  }) : super(
          sprite: sprite,
          position: position,
          size: Vector2.all(28),
          anchor: Anchor.center,
        );

  bool collected = false;
  double _collectTimer = 0;
  double _spinTimer = 0;

  Rect get worldRect =>
      Rect.fromCenter(center: Offset(position.x, position.y), width: size.x, height: size.y);

  @override
  Future<void> onLoad() async {
    await add(
      CircleHitbox()
        ..collisionType = CollisionType.passive,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spinTimer += dt;
    if (collected) {
      _collectTimer += dt;
      final t = (_collectTimer / 0.22).clamp(0.0, 1.0);
      scale = Vector2.all(1 + t * 0.8);
      opacity = 1 - t;
      angle += dt * 18;
      if (t >= 1) {
        removeFromParent();
      }
      return;
    }
    angle += dt * 4;
    scale = Vector2.all(1 + math.sin(_spinTimer * 6) * 0.06);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final center = Offset(size.x / 2, size.y / 2);
    final outer = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final inner = Paint()
      ..color = const Color(0xFFFFF3B0).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, size.x / 2 - 3, outer);
    canvas.drawCircle(center, size.x / 2 - 6, inner);
  }
}
