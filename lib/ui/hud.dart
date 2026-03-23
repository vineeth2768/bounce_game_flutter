import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../game/bounce_game.dart';
import '../utils/constants.dart';
import 'game_over.dart';
import 'pause_menu.dart';

class GameStage extends StatelessWidget {
  const GameStage({
    super.key,
    required this.game,
    required this.onExitToMenu,
  });

  final BounceGame game;
  final VoidCallback onExitToMenu;

  @override
  Widget build(BuildContext context) {
    final showTouchControls =
        !kIsWeb || MediaQuery.sizeOf(context).shortestSide < 700;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A1B33), Color(0xFF07111F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _BackdropPainter(),
              ),
            ),
          ),
          Positioned.fill(
            child: GameWidget<BounceGame>(
              game: game,
              autofocus: true,
            ),
          ),
          SafeArea(
            child: ValueListenableBuilder<HudState>(
              valueListenable: game.hud,
              builder: (context, hud, _) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    _HudBar(hud: hud, onPause: game.togglePause, onRestart: game.restartCurrentLevel),
                    if (showTouchControls) _MobileControls(game: game),
                    if (hud.isPaused)
                      PauseMenu(
                        onResume: game.togglePause,
                        onRestart: game.restartCurrentLevel,
                        onExit: onExitToMenu,
                      ),
                    if (hud.isLevelComplete && !hud.isVictory)
                      ResultOverlay(
                        title: 'Level Complete',
                        subtitle: 'Time bonus applied. Continue to the next level.',
                        onPrimary: game.continueToNextLevel,
                        primaryLabel: 'Next Level',
                        onExit: onExitToMenu,
                      ),
                    if (hud.isGameOver)
                      ResultOverlay(
                        title: 'Game Over',
                        subtitle: 'Score: ${hud.score}',
                        onPrimary: () => game.restartGame(startLevel: hud.currentLevel),
                        primaryLabel: 'Retry Level',
                        onExit: onExitToMenu,
                      ),
                    if (hud.isVictory)
                      ResultOverlay(
                        title: 'Victory',
                        subtitle: 'Final Score: ${hud.score}',
                        onPrimary: () => game.restartGame(),
                        primaryLabel: 'Play Again',
                        onExit: onExitToMenu,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BackdropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stars = Paint()..color = const Color(0x99FFFFFF);
    final hillFar = Paint()..color = const Color(0xFF124B79);
    final hillNear = Paint()..color = const Color(0xFF1B8E6B);

    for (var i = 0; i < 80; i++) {
      final x = (i * 97) % size.width;
      final y = 20 + ((i * 53) % (size.height * 0.18));
      canvas.drawCircle(Offset(x, y.toDouble()), 1.2, stars);
    }

    final horizon = size.height * 0.18;
    final far = Path()..moveTo(0, horizon + 40);
    for (double x = 0; x <= size.width + 60; x += 60) {
      far.lineTo(x, horizon + ((x / 60).round().isEven ? 8 : 28));
    }
    far.lineTo(size.width, size.height);
    far.lineTo(0, size.height);
    far.close();

    final near = Path()..moveTo(0, horizon + 52);
    for (double x = 0; x <= size.width + 55; x += 55) {
      near.lineTo(x, horizon + ((x / 55).round().isEven ? 12 : 40));
    }
    near.lineTo(size.width, size.height);
    near.lineTo(0, size.height);
    near.close();

    canvas.drawPath(far, hillFar);
    canvas.drawPath(near, hillNear);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HudBar extends StatelessWidget {
  const _HudBar({
    required this.hud,
    required this.onPause,
    required this.onRestart,
  });

  final HudState hud;
  final VoidCallback onPause;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _Chip(label: 'Score', value: '${hud.score}'),
                _Chip(label: 'Lives', value: '${hud.lives}'),
                _Chip(label: 'Rings', value: '${hud.ringsRemaining}'),
                _Chip(label: 'Level', value: '${hud.currentLevel}'),
                _Chip(label: 'Exit', value: hud.unlockedExit ? 'Open' : 'Locked'),
              ],
            ),
          ),
          Row(
            children: [
              FilledButton(onPressed: onRestart, child: const Text('Restart')),
              const SizedBox(width: 8),
              FilledButton(onPressed: onPause, child: Text(hud.isPaused ? 'Resume' : 'Pause')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xCC0B1726),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x44FFFFFF)),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _MobileControls extends StatelessWidget {
  const _MobileControls({required this.game});

  final BounceGame game;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      right: 12,
      bottom: 12,
      child: Row(
        children: [
          _HoldButton(
            icon: Icons.arrow_left,
            onPressedChanged: game.setLeftPressed,
          ),
          const SizedBox(width: 10),
          _HoldButton(
            icon: Icons.arrow_right,
            onPressedChanged: game.setRightPressed,
          ),
          const Spacer(),
          _TapButton(
            icon: Icons.arrow_upward,
            onTap: game.requestJump,
          ),
        ],
      ),
    );
  }
}

class _HoldButton extends StatelessWidget {
  const _HoldButton({
    required this.icon,
    required this.onPressedChanged,
  });

  final IconData icon;
  final ValueChanged<bool> onPressedChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onPressedChanged(true),
      onTapUp: (_) => onPressedChanged(false),
      onTapCancel: () => onPressedChanged(false),
      child: _ControlButton(icon: icon),
    );
  }
}

class _TapButton extends StatelessWidget {
  const _TapButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _ControlButton(icon: icon),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: GameConstants.mobileButtonSize,
      height: GameConstants.mobileButtonSize,
      decoration: BoxDecoration(
        color: const Color(0xCC10243B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x44FFFFFF)),
      ),
      child: Icon(icon, size: 30),
    );
  }
}


