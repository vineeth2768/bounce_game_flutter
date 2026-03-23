import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CheckpointComponent extends PositionComponent {
  CheckpointComponent({required Vector2 position})
      : super(
          position: position,
          size: Vector2(20, 56),
          anchor: Anchor.bottomCenter,
        );

  bool active = false;

  Rect get triggerRect => Rect.fromLTWH(position.x - 26, position.y - size.y, 52, size.y);

  @override
  Future<void> onLoad() async {
    await add(
      RectangleHitbox.relative(
        Vector2(2.6, 1),
        parentSize: size,
        anchor: Anchor.center,
      )..collisionType = CollisionType.passive,
    );
  }

  @override
  void render(Canvas canvas) {
    final pole = Paint()..color = const Color(0xFFE7EEF8);
    final flag = Paint()..color = active ? const Color(0xFF7CFC87) : const Color(0xFFF9C74F);
    canvas.drawRect(Rect.fromLTWH(8, 0, 4, size.y), pole);
    canvas.drawPath(
      Path()
        ..moveTo(12, 6)
        ..lineTo(size.x, 14)
        ..lineTo(12, 24)
        ..close(),
      flag,
    );
  }
}
