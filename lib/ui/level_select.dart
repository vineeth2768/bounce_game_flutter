import 'package:flutter/material.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({
    super.key,
    required this.highestUnlockedLevel,
    required this.onBack,
    required this.onSelectLevel,
  });

  final int highestUnlockedLevel;
  final VoidCallback onBack;
  final ValueChanged<int> onSelectLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
        title: const Text('Level Select'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              final level = index + 1;
              final unlocked = level <= highestUnlockedLevel;
              return FilledButton(
                onPressed: unlocked ? () => onSelectLevel(level) : null,
                child: Text(unlocked ? 'Level $level' : 'Locked'),
              );
            },
          ),
        ),
      ),
    );
  }
}
