import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../audio/audio_manager.dart';
import '../effects/particles.dart';
import '../effects/screen_shake.dart';
import '../levels/level1.dart';
import '../utils/constants.dart';
import 'checkpoint.dart';
import 'door.dart';
import 'enemy.dart';
import 'level_manager.dart';
import 'moving_platform.dart';
import 'platform.dart';
import 'player.dart';
import 'ring.dart';
import 'spike.dart';

class BounceGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  BounceGame({
    required this.audio,
    required this.initialSaveData,
    required this.onSaveDataChanged,
    this.initialLevel = 1,
  }) : super(
          world: World(),
          camera: CameraComponent.withFixedResolution(
            width: GameConstants.viewportWidth,
            height: GameConstants.viewportHeight,
          ),
        );

  final AudioManager audio;
  final SaveData initialSaveData;
  final ValueChanged<SaveData> onSaveDataChanged;
  final int initialLevel;

  late final PlayerComponent player;
  late final LevelManager levelManager;
  late final Sprite ballSprite;
  late final Sprite ringSprite;
  late final Sprite spikeSprite;
  late final Sprite enemySprite;
  late final Sprite platformSprite;

  final ValueNotifier<HudState> hud = ValueNotifier(
    const HudState(
      score: 0,
      lives: GameConstants.initialLives,
      ringsRemaining: 0,
      currentLevel: 1,
      unlockedExit: false,
      isPaused: false,
      isLevelComplete: false,
      isGameOver: false,
      isVictory: false,
    ),
  );

  final ScreenShakeController screenShake = ScreenShakeController();
  final List<PlatformComponent> platforms = [];
  final List<MovingPlatformComponent> movingPlatforms = [];
  final List<SpikeComponent> spikes = [];
  final List<RingComponent> rings = [];
  final List<CheckpointComponent> checkpoints = [];
  final List<EnemyComponent> enemies = [];

  DoorComponent? door;
  Vector2 respawnPoint = Vector2.zero();
  LevelDefinition currentLevel = level1;

  int lives = GameConstants.initialLives;
  int score = 0;
  int ringsRemaining = 0;
  int currentLevelIndex = 0;
  int highestUnlockedLevel = 1;
  int highScore = 0;
  bool levelReady = false;
  bool isPausedState = false;
  bool isGameOver = false;
  bool isVictory = false;
  bool isLevelComplete = false;
  bool _disposed = false;
  double _levelTimer = 0;

  List<SolidSurface> get solids => [...platforms, ...movingPlatforms];

  @override
  Color backgroundColor() => const Color(0xFF07111F);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    if (_disposed) {
      return;
    }

    highestUnlockedLevel = initialSaveData.highestUnlockedLevel;
    highScore = initialSaveData.highScore;
    currentLevelIndex = initialLevel - 1;

    ballSprite = await loadSprite(AssetPaths.ball);
    ringSprite = await loadSprite(AssetPaths.ring);
    spikeSprite = await loadSprite(AssetPaths.spike);
    enemySprite = await loadSprite(AssetPaths.enemy);
    platformSprite = await loadSprite(AssetPaths.platform);

    player = PlayerComponent(sprite: ballSprite);
    levelManager = LevelManager();
    await add(levelManager);
    await loadLevel(resetLives: true, resetScore: true);
    await audio.playMusic();
  }

  Future<void> loadLevel({
    bool resetLives = false,
    bool resetScore = false,
  }) async {
    if (_disposed) {
      return;
    }
    if (resetLives) {
      lives = GameConstants.initialLives;
    }
    if (resetScore) {
      score = 0;
    }
    isPausedState = false;
    isGameOver = false;
    isVictory = false;
    isLevelComplete = false;
    _levelTimer = 0;
    resumeEngine();
    player.moveLeft = false;
    player.moveRight = false;

    currentLevel = await levelManager.loadLevel(currentLevelIndex);
    camera.follow(
      player,
      maxSpeed: 1200,
      snap: true,
      horizontalOnly: true,
    );
    camera.setBounds(
      Rectangle.fromLTWH(
        0,
        0,
        currentLevel.worldSize.width,
        currentLevel.worldSize.height,
      ),
      considerViewport: true,
    );
    _positionCameraForLevel();
    ringsRemaining = currentLevel.rings.length;
    _syncDoor();
    _syncHud();
  }

  void _positionCameraForLevel() {
    final visibleHeight = GameConstants.viewportHeight;
    final minY = visibleHeight / 2;
    final maxY = currentLevel.worldSize.height - visibleHeight / 2;
    final targetY = currentLevel.worldSize.height - visibleHeight * 0.55;
    camera.viewfinder.position.y = targetY.clamp(minY, maxY);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_disposed) {
      return;
    }
    if (!isPausedState && !isGameOver && !isLevelComplete && levelReady) {
      _levelTimer += dt;
    }
    screenShake.update(dt);
  }

  void setLeftPressed(bool value) {
    if (_disposed) {
      return;
    }
    player.moveLeft = value;
  }

  void setRightPressed(bool value) {
    if (_disposed) {
      return;
    }
    player.moveRight = value;
  }

  void requestJump() {
    if (_disposed || isPausedState) {
      return;
    }
    player.requestJump();
  }

  void onRingCollected(RingComponent ring) {
    if (_disposed || ring.collected) {
      return;
    }
    ring.collected = true;
    ringsRemaining--;
    score += GameConstants.ringScore;
    world.add(ringCollectEffect(ring.position));
    audio.playRing();
    _syncDoor();
    _syncHud();
  }

  void activateCheckpoint(CheckpointComponent checkpoint) {
    for (final item in checkpoints) {
      item.active = identical(item, checkpoint);
    }
    respawnPoint = Vector2(checkpoint.position.x, checkpoint.position.y - 18);
  }

  void triggerHitEffects(Vector2 position) {
    screenShake.shake(duration: 0.22, intensity: 12);
    world.add(playerDeathEffect(position));
    audio.playHit();
  }

  Future<void> onPlayerDamaged() async {
    if (_disposed || !levelReady) {
      return;
    }
    levelReady = false;
    lives--;
    _syncHud();
    if (lives <= 0) {
      isGameOver = true;
      pauseEngine();
      _syncHud();
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (_disposed) {
      return;
    }
    player.respawn(respawnPoint);
    levelReady = true;
  }

  void _syncDoor() {
    if (door == null) {
      return;
    }
    door!.unlocked = ringsRemaining == 0;
  }

  Future<void> tryCompleteLevel() async {
    if (_disposed || isLevelComplete || door == null || !door!.unlocked) {
      return;
    }

    isLevelComplete = true;
    pauseEngine();
    final timeBonus = (currentLevel.parTimeSeconds * 20 - (_levelTimer * 10).round()).clamp(0, 999);
    score += GameConstants.levelCompleteScore + timeBonus;
    await audio.playLevelComplete();

    if (currentLevel.number >= highestUnlockedLevel && currentLevel.number < levelManager.levels.length) {
      highestUnlockedLevel = currentLevel.number + 1;
    }
    if (score > highScore) {
      highScore = score;
    }
    onSaveDataChanged(
      SaveData(
        highestUnlockedLevel: highestUnlockedLevel,
        highScore: highScore,
      ),
    );

    if (currentLevelIndex >= levelManager.levels.length - 1) {
      isVictory = true;
    }
    _syncHud();
  }

  Future<void> continueToNextLevel() async {
    if (_disposed) {
      return;
    }
    if (currentLevelIndex >= levelManager.levels.length - 1) {
      isVictory = true;
      pauseEngine();
      _syncHud();
      return;
    }
    currentLevelIndex++;
    await loadLevel();
  }

  Future<void> restartCurrentLevel() async {
    if (_disposed) {
      return;
    }
    resumeEngine();
    await loadLevel();
  }

  Future<void> restartGame({int startLevel = 1}) async {
    if (_disposed) {
      return;
    }
    currentLevelIndex = startLevel - 1;
    resumeEngine();
    await loadLevel(resetLives: true, resetScore: true);
  }

  void togglePause() {
    if (_disposed || isGameOver || isLevelComplete) {
      return;
    }
    isPausedState = !isPausedState;
    _syncHud();
    player.moveLeft = false;
    player.moveRight = false;
    if (isPausedState) {
      pauseEngine();
    } else {
      resumeEngine();
    }
  }

  void _syncHud() {
    hud.value = hud.value.copyWith(
      score: score,
      lives: lives,
      ringsRemaining: ringsRemaining,
      currentLevel: currentLevel.number,
      unlockedExit: door?.unlocked ?? false,
      isPaused: isPausedState,
      isLevelComplete: isLevelComplete,
      isGameOver: isGameOver,
      isVictory: isVictory,
    );
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (_disposed) {
      return KeyEventResult.ignored;
    }
    final isDown = event is KeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.escape && isDown) {
      togglePause();
      return KeyEventResult.handled;
    }

    setLeftPressed(keysPressed.contains(LogicalKeyboardKey.arrowLeft));
    setRightPressed(keysPressed.contains(LogicalKeyboardKey.arrowRight));
    if (isDown &&
        (event.logicalKey == LogicalKeyboardKey.arrowUp ||
            event.logicalKey == LogicalKeyboardKey.space)) {
      requestJump();
    }
    return KeyEventResult.handled;
  }

  @override
  void onDispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    pauseEngine();
    audio.stopMusic();
    hud.dispose();
    super.onDispose();
  }
}
