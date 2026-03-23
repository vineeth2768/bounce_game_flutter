import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

abstract class SolidSurface extends SpriteComponent {
  SolidSurface({
    super.sprite,
    required super.position,
    required super.size,
  });

  Rect get worldRect => Rect.fromLTWH(position.x, position.y, size.x, size.y);
  Vector2 get frameDelta => Vector2.zero();
}

class PlatformComponent extends SolidSurface {
  PlatformComponent({
    required Sprite sprite,
    required Rect rect,
  }) : super(
          sprite: sprite,
          position: Vector2(rect.left, rect.top),
          size: Vector2(rect.width, rect.height),
        );

  @override
  Future<void> onLoad() async {
    await add(
      RectangleHitbox()
        ..collisionType = CollisionType.passive,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final fill = Paint()..color = const Color(0xFF4FC3F7);
    final stroke = Paint()
      ..color = const Color(0xFFB3E5FC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final rect = RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8));
    canvas.drawRRect(rect, fill);
    canvas.drawRRect(rect, stroke);
  }
}
