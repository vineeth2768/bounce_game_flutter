import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class SpikeComponent extends SpriteComponent {
  SpikeComponent({
    required Sprite sprite,
    required Rect rect,
  }) : super(
          sprite: sprite,
          position: Vector2(rect.left, rect.top),
          size: Vector2(rect.width, rect.height),
        );

  double _impactFlash = 0;

  Rect get worldRect => Rect.fromLTWH(position.x, position.y, size.x, size.y);

  void flash() {
    _impactFlash = 0.25;
  }

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
    if (_impactFlash > 0) {
      _impactFlash = (_impactFlash - dt).clamp(0, 0.25);
      opacity = 0.65 + (_impactFlash / 0.25) * 0.35;
    } else {
      opacity = 1;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final path = Path();
    const teeth = 4;
    final step = size.x / teeth;
    path.moveTo(0, size.y);
    for (var i = 0; i < teeth; i++) {
      path.lineTo(i * step + step / 2, 0);
      path.lineTo((i + 1) * step, size.y);
    }
    path.close();
    final fill = Paint()..color = const Color(0xFFFF595E).withValues(alpha: opacity);
    final stroke = Paint()
      ..color = const Color(0xFFFFD6D8).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }
}
