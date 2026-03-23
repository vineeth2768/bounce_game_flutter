import 'dart:ui';

import '../utils/constants.dart';

const LevelDefinition level3 = LevelDefinition(
  number: 3,
  worldSize: Size(1760, 700),
  playerStart: Offset(76, 540),
  platforms: [
    PlatformSpec(Rect.fromLTWH(0, 640, 1760, 60)),
    PlatformSpec(Rect.fromLTWH(30, 560, 160, 18)),
    PlatformSpec(Rect.fromLTWH(250, 515, 110, 18)),
    PlatformSpec(Rect.fromLTWH(420, 470, 110, 18)),
    PlatformSpec(Rect.fromLTWH(590, 430, 110, 18)),
    PlatformSpec(Rect.fromLTWH(770, 385, 110, 18)),
    PlatformSpec(Rect.fromLTWH(960, 340, 110, 18)),
    PlatformSpec(Rect.fromLTWH(1150, 295, 110, 18)),
    PlatformSpec(Rect.fromLTWH(1340, 250, 110, 18)),
    PlatformSpec(Rect.fromLTWH(1520, 205, 110, 18)),
  ],
  movingPlatforms: [
    MovingPlatformSpec(
      start: Offset(345, 560),
      end: Offset(505, 560),
      size: Size(90, 18),
      speed: 90,
    ),
    MovingPlatformSpec(
      start: Offset(1270, 420),
      end: Offset(1420, 420),
      size: Size(100, 18),
      speed: 75,
    ),
  ],
  spikes: [
    SpikeSpec(Rect.fromLTWH(205, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(540, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(903, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1260, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1638, 622, 42, 18)),
  ],
  rings: [
    RingSpec(Offset(105, 517)),
    RingSpec(Offset(303, 473)),
    RingSpec(Offset(473, 428)),
    RingSpec(Offset(648, 388)),
    RingSpec(Offset(830, 342)),
    RingSpec(Offset(1014, 298)),
    RingSpec(Offset(1205, 252)),
    RingSpec(Offset(1395, 208)),
    RingSpec(Offset(1572, 163)),
  ],
  checkpoints: [
    CheckpointSpec(Offset(862, 638)),
  ],
  enemies: [
    EnemySpec(
      type: EnemyType.patrol,
      start: Offset(784, 355),
      end: Offset(852, 355),
      size: Size(32, 32),
      speed: 70,
    ),
    EnemySpec(
      type: EnemyType.rolling,
      start: Offset(1348, 222),
      end: Offset(1420, 222),
      size: Size(28, 28),
      speed: 100,
    ),
  ],
  exitPosition: Offset(1575, 136),
  exitSize: Size(44, 68),
  parTimeSeconds: 43,
);
