import 'dart:ui';

import '../utils/constants.dart';

const LevelDefinition level6 = LevelDefinition(
  number: 6,
  worldSize: Size(2150, 760),
  playerStart: Offset(80, 600),
  platforms: [
    PlatformSpec(Rect.fromLTWH(0, 700, 2150, 60)),
    PlatformSpec(Rect.fromLTWH(45, 620, 130, 18)),
    PlatformSpec(Rect.fromLTWH(230, 590, 100, 18)),
    PlatformSpec(Rect.fromLTWH(390, 540, 100, 18)),
    PlatformSpec(Rect.fromLTWH(550, 500, 100, 18)),
    PlatformSpec(Rect.fromLTWH(720, 460, 100, 18)),
    PlatformSpec(Rect.fromLTWH(900, 420, 100, 18)),
    PlatformSpec(Rect.fromLTWH(1090, 380, 100, 18)),
    PlatformSpec(Rect.fromLTWH(1280, 340, 100, 18)),
    PlatformSpec(Rect.fromLTWH(1470, 300, 100, 18)),
    PlatformSpec(Rect.fromLTWH(1660, 260, 100, 18)),
    PlatformSpec(Rect.fromLTWH(1840, 220, 100, 18)),
  ],
  movingPlatforms: [
    MovingPlatformSpec(
      start: Offset(620, 620),
      end: Offset(620, 520),
      size: Size(90, 18),
      speed: 90,
    ),
    MovingPlatformSpec(
      start: Offset(1180, 500),
      end: Offset(1360, 500),
      size: Size(100, 18),
      speed: 95,
    ),
    MovingPlatformSpec(
      start: Offset(1720, 380),
      end: Offset(1900, 380),
      size: Size(100, 18),
      speed: 100,
    ),
  ],
  spikes: [
    SpikeSpec(Rect.fromLTWH(182, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(338, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(500, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(666, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(842, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1594, 682, 42, 18)),
  ],
  rings: [
    RingSpec(Offset(110, 578)),
    RingSpec(Offset(278, 548)),
    RingSpec(Offset(440, 498)),
    RingSpec(Offset(600, 458)),
    RingSpec(Offset(770, 418)),
    RingSpec(Offset(948, 378)),
    RingSpec(Offset(1138, 338)),
    RingSpec(Offset(1328, 298)),
    RingSpec(Offset(1518, 258)),
    RingSpec(Offset(1888, 178)),
  ],
  checkpoints: [
    CheckpointSpec(Offset(1080, 698)),
    CheckpointSpec(Offset(1680, 258)),
  ],
  enemies: [
    EnemySpec(
      type: EnemyType.patrol,
      start: Offset(725, 430),
      end: Offset(792, 430),
      size: Size(30, 30),
      speed: 88,
    ),
    EnemySpec(
      type: EnemyType.rolling,
      start: Offset(1478, 268),
      end: Offset(1542, 268),
      size: Size(28, 28),
      speed: 120,
    ),
  ],
  exitPosition: Offset(1895, 152),
  exitSize: Size(44, 68),
  parTimeSeconds: 55,
);
