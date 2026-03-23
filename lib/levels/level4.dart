import 'dart:ui';

import '../utils/constants.dart';

const LevelDefinition level4 = LevelDefinition(
  number: 4,
  worldSize: Size(1880, 700),
  playerStart: Offset(70, 540),
  platforms: [
    PlatformSpec(Rect.fromLTWH(0, 640, 1880, 60)),
    PlatformSpec(Rect.fromLTWH(70, 520, 150, 18)),
    PlatformSpec(Rect.fromLTWH(290, 490, 140, 18)),
    PlatformSpec(Rect.fromLTWH(500, 450, 140, 18)),
    PlatformSpec(Rect.fromLTWH(740, 410, 140, 18)),
    PlatformSpec(Rect.fromLTWH(980, 360, 130, 18)),
    PlatformSpec(Rect.fromLTWH(1180, 320, 130, 18)),
    PlatformSpec(Rect.fromLTWH(1360, 280, 130, 18)),
    PlatformSpec(Rect.fromLTWH(1560, 240, 130, 18)),
  ],
  movingPlatforms: [
    MovingPlatformSpec(
      start: Offset(610, 560),
      end: Offset(610, 470),
      size: Size(110, 18),
      speed: 85,
    ),
    MovingPlatformSpec(
      start: Offset(1100, 470),
      end: Offset(1280, 470),
      size: Size(110, 18),
      speed: 95,
    ),
    MovingPlatformSpec(
      start: Offset(1480, 390),
      end: Offset(1640, 390),
      size: Size(100, 18),
      speed: 90,
    ),
  ],
  spikes: [
    SpikeSpec(Rect.fromLTWH(230, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(440, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(652, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(890, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1112, 622, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1506, 622, 42, 18)),
  ],
  rings: [
    RingSpec(Offset(140, 478)),
    RingSpec(Offset(362, 448)),
    RingSpec(Offset(572, 407)),
    RingSpec(Offset(665, 428)),
    RingSpec(Offset(808, 368)),
    RingSpec(Offset(1040, 317)),
    RingSpec(Offset(1240, 278)),
    RingSpec(Offset(1420, 238)),
    RingSpec(Offset(1610, 198)),
  ],
  checkpoints: [
    CheckpointSpec(Offset(958, 638)),
  ],
  enemies: [
    EnemySpec(
      type: EnemyType.patrol,
      start: Offset(517, 420),
      end: Offset(612, 420),
      size: Size(30, 30),
      speed: 80,
    ),
    EnemySpec(
      type: EnemyType.rolling,
      start: Offset(1188, 288),
      end: Offset(1270, 288),
      size: Size(28, 28),
      speed: 105,
    ),
  ],
  exitPosition: Offset(1645, 171),
  exitSize: Size(44, 68),
  parTimeSeconds: 48,
);
