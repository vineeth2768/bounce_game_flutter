import 'dart:ui';

enum EnemyType { rolling, patrol }

class GameConstants {
  static const double viewportWidth = 960;
  static const double viewportHeight = 540;
  static const double gravity = 1850;
  static const double playerMoveSpeed = 280;
  static const double playerAcceleration = 1900;
  static const double playerGroundFriction = 2300;
  static const double playerAirControl = 1450;
  static const double playerJumpVelocity = 760;
  static const double playerBounceVelocity = 220;
  static const double coyoteTime = 0.1;
  static const double jumpBufferTime = 0.12;
  static const double playerSize = 34;
  static const double mobileButtonSize = 68;
  static const int initialLives = 3;
  static const int ringScore = 100;
  static const int levelCompleteScore = 250;
}

class AssetPaths {
  static const String ball = 'ball.png';
  static const String ring = 'ring.png';
  static const String spike = 'spike.png';
  static const String enemy = 'enemy.png';
  static const String platform = 'platform.png';
  static const String background1 = 'background/layer1.png';
  static const String background2 = 'background/layer2.png';
  static const String background3 = 'background/layer3.png';

  static const String jumpSound = 'sounds/jump.wav';
  static const String ringSound = 'sounds/ring.wav';
  static const String hitSound = 'sounds/hit.wav';
  static const String levelCompleteSound = 'sounds/level_complete.wav';
  static const String music = 'music/background.mp3';
}

class PlatformSpec {
  const PlatformSpec(this.rect);

  final Rect rect;
}

class MovingPlatformSpec {
  const MovingPlatformSpec({
    required this.start,
    required this.end,
    required this.size,
    required this.speed,
  });

  final Offset start;
  final Offset end;
  final Size size;
  final double speed;
}

class SpikeSpec {
  const SpikeSpec(this.rect);

  final Rect rect;
}

class RingSpec {
  const RingSpec(this.position);

  final Offset position;
}

class CheckpointSpec {
  const CheckpointSpec(this.position);

  final Offset position;
}

class EnemySpec {
  const EnemySpec({
    required this.type,
    required this.start,
    required this.end,
    required this.size,
    required this.speed,
  });

  final EnemyType type;
  final Offset start;
  final Offset end;
  final Size size;
  final double speed;
}

class LevelDefinition {
  const LevelDefinition({
    required this.number,
    required this.worldSize,
    required this.playerStart,
    required this.platforms,
    required this.movingPlatforms,
    required this.spikes,
    required this.rings,
    required this.checkpoints,
    required this.enemies,
    required this.exitPosition,
    required this.exitSize,
    this.parTimeSeconds = 45,
  });

  final int number;
  final Size worldSize;
  final Offset playerStart;
  final List<PlatformSpec> platforms;
  final List<MovingPlatformSpec> movingPlatforms;
  final List<SpikeSpec> spikes;
  final List<RingSpec> rings;
  final List<CheckpointSpec> checkpoints;
  final List<EnemySpec> enemies;
  final Offset exitPosition;
  final Size exitSize;
  final int parTimeSeconds;
}

class SaveData {
  const SaveData({
    required this.highestUnlockedLevel,
    required this.highScore,
  });

  final int highestUnlockedLevel;
  final int highScore;

  SaveData copyWith({
    int? highestUnlockedLevel,
    int? highScore,
  }) {
    return SaveData(
      highestUnlockedLevel: highestUnlockedLevel ?? this.highestUnlockedLevel,
      highScore: highScore ?? this.highScore,
    );
  }
}

class HudState {
  const HudState({
    required this.score,
    required this.lives,
    required this.ringsRemaining,
    required this.currentLevel,
    required this.unlockedExit,
    required this.isPaused,
    required this.isLevelComplete,
    required this.isGameOver,
    required this.isVictory,
  });

  final int score;
  final int lives;
  final int ringsRemaining;
  final int currentLevel;
  final bool unlockedExit;
  final bool isPaused;
  final bool isLevelComplete;
  final bool isGameOver;
  final bool isVictory;

  HudState copyWith({
    int? score,
    int? lives,
    int? ringsRemaining,
    int? currentLevel,
    bool? unlockedExit,
    bool? isPaused,
    bool? isLevelComplete,
    bool? isGameOver,
    bool? isVictory,
  }) {
    return HudState(
      score: score ?? this.score,
      lives: lives ?? this.lives,
      ringsRemaining: ringsRemaining ?? this.ringsRemaining,
      currentLevel: currentLevel ?? this.currentLevel,
      unlockedExit: unlockedExit ?? this.unlockedExit,
      isPaused: isPaused ?? this.isPaused,
      isLevelComplete: isLevelComplete ?? this.isLevelComplete,
      isGameOver: isGameOver ?? this.isGameOver,
      isVictory: isVictory ?? this.isVictory,
    );
  }
}
