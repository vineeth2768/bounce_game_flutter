import 'dart:ui';

import '../utils/constants.dart';

const LevelDefinition level2 = LevelDefinition(
  number: 2,
  worldSize: Size(1650, 660),
  playerStart: Offset(80, 500),
  platforms: [
    PlatformSpec(Rect.fromLTWH(0, 600, 1650, 60)),
    PlatformSpec(Rect.fromLTWH(70, 520, 120, 18)),
    PlatformSpec(Rect.fromLTWH(240, 470, 120, 18)),
    PlatformSpec(Rect.fromLTWH(420, 420, 140, 18)),
    PlatformSpec(Rect.fromLTWH(650, 370, 120, 18)),
    PlatformSpec(Rect.fromLTWH(830, 320, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1030, 280, 130, 18)),
    PlatformSpec(Rect.fromLTWH(1230, 240, 130, 18)),
    PlatformSpec(Rect.fromLTWH(1420, 200, 120, 18)),
  ],
  movingPlatforms: [
    MovingPlatformSpec(
      start: Offset(525, 520),
      end: Offset(525, 430),
      size: Size(100, 18),
      speed: 70,
    ),
    MovingPlatformSpec(
      start: Offset(1180, 380),
      end: Offset(1350, 380),
      size: Size(110, 18),
      speed: 85,
    ),
  ],
  spikes: [
    SpikeSpec(Rect.fromLTWH(365, 582, 42, 18)),
    SpikeSpec(Rect.fromLTWH(585, 582, 42, 18)),
    SpikeSpec(Rect.fromLTWH(782, 582, 42, 18)),
    SpikeSpec(Rect.fromLTWH(970, 582, 42, 18)),
  ],
  rings: [
    RingSpec(Offset(120, 478)),
    RingSpec(Offset(295, 428)),
    RingSpec(Offset(490, 378)),
    RingSpec(Offset(575, 385)),
    RingSpec(Offset(705, 328)),
    RingSpec(Offset(890, 278)),
    RingSpec(Offset(1095, 237)),
    RingSpec(Offset(1480, 158)),
  ],
  checkpoints: [
    CheckpointSpec(Offset(700, 598)),
    CheckpointSpec(Offset(1250, 238)),
  ],
  enemies: [
    EnemySpec(
      type: EnemyType.rolling,
      start: Offset(1030, 247),
      end: Offset(1120, 247),
      size: Size(28, 28),
      speed: 95,
    ),
  ],
  exitPosition: Offset(1510, 132),
  exitSize: Size(44, 68),
  parTimeSeconds: 40,
);
