import 'dart:ui';

import '../utils/constants.dart';

const LevelDefinition level1 = LevelDefinition(
  number: 1,
  worldSize: Size(1500, 620),
  playerStart: Offset(80, 470),
  platforms: [
    PlatformSpec(Rect.fromLTWH(0, 560, 1500, 60)),
    PlatformSpec(Rect.fromLTWH(70, 490, 170, 18)),
    PlatformSpec(Rect.fromLTWH(330, 440, 170, 18)),
    PlatformSpec(Rect.fromLTWH(560, 390, 160, 18)),
    PlatformSpec(Rect.fromLTWH(810, 340, 160, 18)),
    PlatformSpec(Rect.fromLTWH(1060, 290, 170, 18)),
    PlatformSpec(Rect.fromLTWH(1280, 245, 140, 18)),
  ],
  movingPlatforms: [
    MovingPlatformSpec(
      start: Offset(720, 470),
      end: Offset(900, 470),
      size: Size(110, 18),
      speed: 90,
    ),
  ],
  spikes: [
    SpikeSpec(Rect.fromLTWH(255, 542, 56, 18)),
    SpikeSpec(Rect.fromLTWH(1010, 542, 56, 18)),
  ],
  rings: [
    RingSpec(Offset(150, 450)),
    RingSpec(Offset(412, 400)),
    RingSpec(Offset(640, 350)),
    RingSpec(Offset(865, 300)),
    RingSpec(Offset(1135, 250)),
    RingSpec(Offset(1338, 205)),
  ],
  checkpoints: [
    CheckpointSpec(Offset(750, 558)),
  ],
  enemies: [
    EnemySpec(
      type: EnemyType.patrol,
      start: Offset(585, 360),
      end: Offset(670, 360),
      size: Size(30, 30),
      speed: 70,
    ),
  ],
  exitPosition: Offset(1380, 177),
  exitSize: Size(44, 68),
  parTimeSeconds: 35,
);
