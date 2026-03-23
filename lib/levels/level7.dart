import 'dart:ui';

import '../utils/constants.dart';

const LevelDefinition level7 = LevelDefinition(
  number: 7,
  worldSize: Size(2300, 820),
  playerStart: Offset(80, 660),
  platforms: [
    PlatformSpec(Rect.fromLTWH(0, 760, 2300, 60)),
    PlatformSpec(Rect.fromLTWH(60, 650, 120, 18)),
    PlatformSpec(Rect.fromLTWH(260, 610, 120, 18)),
    PlatformSpec(Rect.fromLTWH(450, 560, 120, 18)),
    PlatformSpec(Rect.fromLTWH(650, 510, 120, 18)),
    PlatformSpec(Rect.fromLTWH(860, 470, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1080, 430, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1300, 390, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1520, 350, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1740, 300, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1960, 250, 120, 18)),
  ],
  movingPlatforms: [
    MovingPlatformSpec(
      start: Offset(390, 700),
      end: Offset(560, 700),
      size: Size(100, 18),
      speed: 100,
    ),
    MovingPlatformSpec(
      start: Offset(990, 570),
      end: Offset(990, 460),
      size: Size(100, 18),
      speed: 90,
    ),
    MovingPlatformSpec(
      start: Offset(1610, 450),
      end: Offset(1810, 450),
      size: Size(100, 18),
      speed: 100,
    ),
  ],
  spikes: [
    SpikeSpec(Rect.fromLTWH(195, 742, 42, 18)),
    SpikeSpec(Rect.fromLTWH(610, 742, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1030, 742, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1450, 742, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1868, 742, 42, 18)),
  ],
  rings: [
    RingSpec(Offset(122, 608)),
    RingSpec(Offset(320, 568)),
    RingSpec(Offset(510, 518)),
    RingSpec(Offset(710, 468)),
    RingSpec(Offset(918, 428)),
    RingSpec(Offset(1140, 388)),
    RingSpec(Offset(1360, 348)),
    RingSpec(Offset(1580, 308)),
    RingSpec(Offset(1800, 258)),
    RingSpec(Offset(2018, 208)),
  ],
  checkpoints: [
    CheckpointSpec(Offset(1140, 758)),
    CheckpointSpec(Offset(1740, 298)),
  ],
  enemies: [
    EnemySpec(
      type: EnemyType.patrol,
      start: Offset(656, 480),
      end: Offset(736, 480),
      size: Size(30, 30),
      speed: 90,
    ),
    EnemySpec(
      type: EnemyType.rolling,
      start: Offset(1525, 318),
      end: Offset(1600, 318),
      size: Size(28, 28),
      speed: 122,
    ),
    EnemySpec(
      type: EnemyType.patrol,
      start: Offset(1968, 218),
      end: Offset(2048, 218),
      size: Size(30, 30),
      speed: 95,
    ),
  ],
  exitPosition: Offset(2045, 183),
  exitSize: Size(44, 68),
  parTimeSeconds: 60,
);
