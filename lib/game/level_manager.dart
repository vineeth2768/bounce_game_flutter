import 'package:flame/components.dart';

import '../levels/level1.dart';
import '../levels/level2.dart';
import '../levels/level3.dart';
import '../levels/level4.dart';
import '../levels/level5.dart';
import '../levels/level6.dart';
import '../levels/level7.dart';
import '../levels/level8.dart';
import '../utils/constants.dart';
import 'bounce_game.dart';
import 'checkpoint.dart';
import 'door.dart';
import 'enemy.dart';
import 'moving_platform.dart';
import 'platform.dart';
import 'ring.dart';
import 'spike.dart';

class LevelManager extends Component with HasGameReference<BounceGame> {
  List<LevelDefinition> get levels => const [
        level1,
        level2,
        level3,
        level4,
        level5,
        level6,
        level7,
        level8,
      ];

  Future<LevelDefinition> loadLevel(int index) async {
    final level = levels[index];
    game.levelReady = false;
    game.world.removeAll(game.world.children.toList());
    game.platforms.clear();
    game.movingPlatforms.clear();
    game.spikes.clear();
    game.rings.clear();
    game.checkpoints.clear();
    game.enemies.clear();
    game.door = null;

    for (final spec in level.platforms) {
      final component = PlatformComponent(
        sprite: game.platformSprite,
        rect: spec.rect,
      );
      game.platforms.add(component);
      await game.world.add(component);
    }

    for (final spec in level.movingPlatforms) {
      final component = MovingPlatformComponent(
        sprite: game.platformSprite,
        start: Vector2(spec.start.dx, spec.start.dy),
        end: Vector2(spec.end.dx, spec.end.dy),
        size: Vector2(spec.size.width, spec.size.height),
        speed: spec.speed,
      );
      game.movingPlatforms.add(component);
      await game.world.add(component);
    }

    for (final spec in level.spikes) {
      final component = SpikeComponent(
        sprite: game.spikeSprite,
        rect: spec.rect,
      );
      game.spikes.add(component);
      await game.world.add(component);
    }

    for (final spec in level.rings) {
      final component = RingComponent(
        sprite: game.ringSprite,
        position: Vector2(spec.position.dx, spec.position.dy),
      );
      game.rings.add(component);
      await game.world.add(component);
    }

    for (final spec in level.checkpoints) {
      final component = CheckpointComponent(
        position: Vector2(spec.position.dx, spec.position.dy),
      );
      game.checkpoints.add(component);
      await game.world.add(component);
    }

    for (final spec in level.enemies) {
      final component = EnemyComponent(
        sprite: game.enemySprite,
        type: spec.type,
        start: Vector2(spec.start.dx, spec.start.dy),
        end: Vector2(spec.end.dx, spec.end.dy),
        size: Vector2(spec.size.width, spec.size.height),
        speed: spec.speed,
      );
      game.enemies.add(component);
      await game.world.add(component);
    }

    final door = DoorComponent(
      position: Vector2(level.exitPosition.dx, level.exitPosition.dy),
      size: Vector2(level.exitSize.width, level.exitSize.height),
    );
    game.door = door;
    await game.world.add(door);

    game.respawnPoint = Vector2(level.playerStart.dx, level.playerStart.dy);
    game.player.respawn(game.respawnPoint);
    await game.world.add(game.player);
    game.levelReady = true;
    return level;
  }
}
