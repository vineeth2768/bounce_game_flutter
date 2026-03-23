import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class DoorComponent extends PositionComponent {
  DoorComponent({
    required super.position,
    required super.size,
  });

  bool unlocked = false;
  double _openProgress = 0;

  Rect get triggerRect => Rect.fromLTWH(position.x, position.y, size.x, size.y);

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
    if (unlocked && _openProgress < 1) {
      _openProgress = (_openProgress + dt * 2.5).clamp(0, 1);
    }
  }

  @override
  void render(Canvas canvas) {
    final outer = Paint()
      ..color = unlocked ? const Color(0xFF43AA8B) : const Color(0xFF6C757D);
    final inner = Paint()
      ..color = unlocked ? const Color(0xFF98F5C9) : const Color(0xFFADB5BD);
    final inset = 6 + _openProgress * 12;
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)),
      outer,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(inset, 6, size.x - inset - 6, size.y - 12),
        const Radius.circular(6),
      ),
      inner,
    );
  }
}
