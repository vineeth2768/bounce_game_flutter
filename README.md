# Bounce Web And Mobile

A Flame-powered 2D platformer inspired by Nokia Bounce, built for Flutter Web and mobile.

## Features

- 8 levels with static and moving platforms
- Rolling and patrol enemies
- Rings, checkpoints, spikes, exit doors, lives, score, and respawn flow
- Keyboard controls for web/desktop and touch controls for mobile
- Main menu, level select, pause, game over, and victory overlays
- 3-layer parallax background
- Save progress with `shared_preferences`
- Sound manager and placeholder audio assets

## Run

```bash
flutter pub get
flutter run -d chrome
```

For Android or iOS:

```bash
flutter run
```

To build for web:

```bash
flutter build web
```

## Controls

Web/Desktop:

- `Left Arrow`: move left
- `Right Arrow`: move right
- `Up Arrow` or `Space`: jump
- `Esc`: pause

Mobile:

- On-screen left button
- On-screen right button
- On-screen jump button

## Project Structure

```text
lib/
|-- main.dart
|-- game/
|   |-- bounce_game.dart
|   |-- checkpoint.dart
|   |-- door.dart
|   |-- enemy.dart
|   |-- level_manager.dart
|   |-- moving_platform.dart
|   |-- platform.dart
|   |-- player.dart
|   |-- ring.dart
|   `-- spike.dart
|-- ui/
|   |-- game_over.dart
|   |-- hud.dart
|   |-- level_select.dart
|   |-- main_menu.dart
|   `-- pause_menu.dart
|-- levels/
|   |-- level1.dart
|   |-- level2.dart
|   |-- level3.dart
|   |-- level4.dart
|   |-- level5.dart
|   |-- level6.dart
|   |-- level7.dart
|   `-- level8.dart
|-- audio/
|   `-- audio_manager.dart
|-- effects/
|   |-- particles.dart
|   `-- screen_shake.dart
`-- utils/
    |-- constants.dart
    `-- helpers.dart
```

## Assets

```text
assets/
|-- images/
|   |-- ball.png
|   |-- enemy.png
|   |-- platform.png
|   |-- ring.png
|   |-- spike.png
|   `-- background/
|       |-- layer1.png
|       |-- layer2.png
|       `-- layer3.png
|-- sounds/
|   |-- hit.wav
|   |-- jump.wav
|   |-- level_complete.wav
|   `-- ring.wav
`-- music/
    `-- background.mp3
```

## Add A New Level

1. Create `lib/levels/level9.dart`.
2. Export a `const LevelDefinition`.
3. Fill:
   - `worldSize`
   - `playerStart`
   - `platforms`
   - `movingPlatforms`
   - `spikes`
   - `rings`
   - `checkpoints`
   - `enemies`
   - `exitPosition`
   - `exitSize`
4. Register the level in `lib/game/level_manager.dart`.
5. Increase the visible level count in `lib/ui/level_select.dart` if needed.

## Notes

- Progress is saved locally with `shared_preferences`.
- Audio assets are placeholders and can be replaced with production assets without code changes.
- `flutter analyze` passes on the current project state.
