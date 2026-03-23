import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    super.key,
    required this.highScore,
    required this.highestUnlockedLevel,
    required this.onPlay,
    required this.onLevelSelect,
  });

  final int highScore;
  final int highestUnlockedLevel;
  final VoidCallback onPlay;
  final VoidCallback onLevelSelect;

  @override
  Widget build(BuildContext context) {
    return _MenuScaffold(
      title: 'Bounce Web',
      subtitle: 'Classic ball platforming rebuilt with Flutter + Flame.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'High Score: $highScore\nUnlocked Level: $highestUnlockedLevel',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFB5CCE6)),
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: onPlay, child: const Text('Start Game')),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: onLevelSelect,
            child: const Text('Level Select'),
          ),
        ],
      ),
    );
  }
}

class _MenuScaffold extends StatelessWidget {
  const _MenuScaffold({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF061428), Color(0xFF0A2440), Color(0xFF0B1525)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xCC081524),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0x44FFFFFF)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFB5CCE6)),
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
