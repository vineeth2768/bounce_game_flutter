import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'bounce_game.dart';
import 'platform.dart';

class PlayerComponent extends SpriteComponent
    with HasGameReference<BounceGame>, CollisionCallbacks {
  PlayerComponent({required Sprite sprite})
      : super(
          sprite: sprite,
          size: Vector2.all(GameConstants.playerSize),
          anchor: Anchor.center,
        );

  final Vector2 velocity = Vector2.zero();
  bool moveLeft = false;
  bool moveRight = false;
  double _jumpBuffer = 0;
  double _coyoteTimer = 0;
  double _squashTimer = 0;
  double _invincibleTimer = 0;
  bool _isRespawning = false;
  SolidSurface? _standingOn;

  Rect get worldRect => Rect.fromCenter(
        center: Offset(position.x, position.y),
        width: size.x,
        height: size.y,
      );

  @override
  Future<void> onLoad() async {
    await add(
      CircleHitbox()
        ..radius = size.x * 0.38
        ..collisionType = CollisionType.active,
    );
  }

  void respawn(Vector2 spawn) {
    position = spawn.clone();
    velocity.setZero();
    _jumpBuffer = 0;
    _coyoteTimer = 0;
    _squashTimer = 0;
    _standingOn = null;
    _isRespawning = false;
    _invincibleTimer = 1.0;
    angle = 0;
    opacity = 1;
    scale = Vector2.all(1);
  }

  void requestJump() {
    _jumpBuffer = GameConstants.jumpBufferTime;
  }

  void hit() {
    if (_isRespawning || _invincibleTimer > 0) {
      return;
    }
    _isRespawning = true;
    game.onPlayerDamaged();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isRespawning || !game.levelReady || game.isPausedState) {
      return;
    }

    if (_jumpBuffer > 0) {
      _jumpBuffer = math.max(0, _jumpBuffer - dt);
    }
    if (_invincibleTimer > 0) {
      _invincibleTimer = math.max(0, _invincibleTimer - dt);
      opacity = _invincibleTimer > 0 ? 0.65 + math.sin(_invincibleTimer * 30) * 0.25 : 1;
    }

    final wasOnGround = _standingOn != null;
    final direction = (moveRight ? 1 : 0) - (moveLeft ? 1 : 0);
    final horizontalControl = wasOnGround
        ? GameConstants.playerAcceleration
        : GameConstants.playerAirControl;
    final targetVelocityX = direction * GameConstants.playerMoveSpeed;

    if (direction != 0) {
      velocity.x = moveToward(velocity.x, targetVelocityX, horizontalControl * dt);
    } else if (wasOnGround) {
      velocity.x = moveToward(
        velocity.x,
        0,
        GameConstants.playerGroundFriction * dt,
      );
    }

    velocity.y += GameConstants.gravity * dt;
    if (wasOnGround) {
      _coyoteTimer = GameConstants.coyoteTime;
    } else if (_coyoteTimer > 0) {
      _coyoteTimer = math.max(0, _coyoteTimer - dt);
    }

    if (_jumpBuffer > 0 && _coyoteTimer > 0) {
      velocity.y = -GameConstants.playerJumpVelocity;
      _jumpBuffer = 0;
      _coyoteTimer = 0;
      _standingOn = null;
      _squashTimer = 0.08;
      game.audio.playJump();
    }

    position.x += velocity.x * dt;
    _resolveHorizontalCollisions(game.solids);

    position.y += velocity.y * dt;
    _standingOn = null;
    _resolveVerticalCollisions(game.solids);

    if (_standingOn != null) {
      position += _standingOn!.frameDelta;
    }

    if (_squashTimer > 0) {
      _squashTimer = math.max(0, _squashTimer - dt);
    }

    _clampToWorld();
    _updateStretch(dt);
    _checkHazardsAndCollectibles();
  }

  void _resolveHorizontalCollisions(List<SolidSurface> solids) {
    for (final platform in solids) {
      if (!worldRect.overlaps(platform.worldRect)) {
        continue;
      }
      if (velocity.x > 0) {
        position.x = platform.worldRect.left - size.x / 2;
      } else if (velocity.x < 0) {
        position.x = platform.worldRect.right + size.x / 2;
      }
      velocity.x = 0;
    }
  }

  void _resolveVerticalCollisions(List<SolidSurface> solids) {
    for (final platform in solids) {
      if (!worldRect.overlaps(platform.worldRect)) {
        continue;
      }
      if (velocity.y > 0) {
        position.y = platform.worldRect.top - size.y / 2;
        velocity.y = 0;
        _standingOn = platform;
        _squashTimer = 0.09;
      } else if (velocity.y < 0) {
        position.y = platform.worldRect.bottom + size.y / 2;
        velocity.y = 80;
      }
    }
  }

  void _clampToWorld() {
    position.x = position.x.clamp(
      size.x / 2,
      game.currentLevel.worldSize.width - size.x / 2,
    );
    if (position.y - size.y / 2 > game.currentLevel.worldSize.height + 120) {
      hit();
    }
  }

  void _updateStretch(double dt) {
    final fallRatio = (velocity.y.abs() / 750).clamp(0.0, 1.0);
    final landingBlend = _squashTimer > 0 ? _squashTimer / 0.09 : 0.0;
    final target = _standingOn != null
        ? Vector2(1.02 + landingBlend * 0.12, 0.98 - landingBlend * 0.14)
        : Vector2(1 + fallRatio * 0.16, 1 - fallRatio * 0.12);

    scale = Vector2(
      scale.x + (target.x - scale.x) * math.min(dt * 12, 1),
      scale.y + (target.y - scale.y) * math.min(dt * 12, 1),
    );
    angle = velocity.x / GameConstants.playerMoveSpeed * 0.08;
  }

  void _checkHazardsAndCollectibles() {
    for (final spike in game.spikes) {
      if (worldRect.overlaps(spike.worldRect)) {
        spike.flash();
        game.triggerHitEffects(position);
        hit();
        return;
      }
    }

    for (final enemy in game.enemies) {
      if (worldRect.overlaps(enemy.worldRect)) {
        game.triggerHitEffects(position);
        hit();
        return;
      }
    }

    for (final ring in game.rings.where((entry) => !entry.collected)) {
      if (worldRect.overlaps(ring.worldRect)) {
        game.onRingCollected(ring);
      }
    }

    for (final checkpoint in game.checkpoints) {
      if (worldRect.overlaps(checkpoint.triggerRect)) {
        game.activateCheckpoint(checkpoint);
      }
    }

    final door = game.door;
    if (door != null && worldRect.overlaps(door.triggerRect)) {
      game.tryCompleteLevel();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final center = Offset(size.x / 2, size.y / 2);
    final shadow = Paint()..color = const Color(0x44000000);
    final body = Paint()..color = const Color(0xFFD62839).withValues(alpha: opacity);
    final outline = Paint()
      ..color = const Color(0xFFFFCDD2).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    final highlight = Paint()..color = const Color(0xAAFFE0E3).withValues(alpha: opacity);
    canvas.drawCircle(Offset(center.dx + 2, center.dy + 4), size.x / 2 - 2, shadow);
    canvas.drawCircle(center, size.x / 2 - 2, body);
    canvas.drawCircle(center, size.x / 2 - 2, outline);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.x * 0.38, size.y * 0.34), width: 10, height: 7),
      highlight,
    );
  }
}
