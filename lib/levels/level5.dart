import 'dart:ui';

import '../utils/constants.dart';

const LevelDefinition level5 = LevelDefinition(
  number: 5,
  worldSize: Size(2050, 760),
  playerStart: Offset(72, 600),
  platforms: [
    PlatformSpec(Rect.fromLTWH(0, 700, 2050, 60)),
    PlatformSpec(Rect.fromLTWH(50, 610, 120, 18)),
    PlatformSpec(Rect.fromLTWH(240, 560, 120, 18)),
    PlatformSpec(Rect.fromLTWH(410, 510, 120, 18)),
    PlatformSpec(Rect.fromLTWH(580, 460, 120, 18)),
    PlatformSpec(Rect.fromLTWH(780, 420, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1020, 380, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1260, 330, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1510, 290, 120, 18)),
    PlatformSpec(Rect.fromLTWH(1750, 250, 120, 18)),
  ],
  movingPlatforms: [
    MovingPlatformSpec(
      start: Offset(330, 650),
      end: Offset(500, 650),
      size: Size(100, 18),
      speed: 95,
    ),
    MovingPlatformSpec(
      start: Offset(890, 560),
      end: Offset(890, 430),
      size: Size(100, 18),
      speed: 85,
    ),
    MovingPlatformSpec(
      start: Offset(1610, 420),
      end: Offset(1800, 420),
      size: Size(110, 18),
      speed: 95,
    ),
  ],
  spikes: [
    SpikeSpec(Rect.fromLTWH(190, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(548, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(918, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1298, 682, 42, 18)),
    SpikeSpec(Rect.fromLTWH(1670, 682, 42, 18)),
  ],
  rings: [
    RingSpec(Offset(108, 568)),
    RingSpec(Offset(300, 518)),
    RingSpec(Offset(470, 468)),
    RingSpec(Offset(640, 418)),
    RingSpec(Offset(830, 378)),
    RingSpec(Offset(1068, 338)),
    RingSpec(Offset(1310, 287)),
    RingSpec(Offset(1560, 248)),
    RingSpec(Offset(1802, 208)),
  ],
  checkpoints: [
    CheckpointSpec(Offset(1000, 698)),
    CheckpointSpec(Offset(1530, 288)),
  ],
  enemies: [
    EnemySpec(
      type: EnemyType.rolling,
      start: Offset(780, 390),
      end: Offset(860, 390),
      size: Size(28, 28),
      speed: 110,
    ),
    EnemySpec(
      type: EnemyType.patrol,
      start: Offset(1268, 298),
      end: Offset(1350, 298),
      size: Size(32, 32),
      speed: 82,
    ),
  ],
  exitPosition: Offset(1810, 182),
  exitSize: Size(44, 68),
  parTimeSeconds: 50,
);
