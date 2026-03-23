import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onExit,
  });

  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return OverlayCard(
      title: 'Paused',
      subtitle: 'Take a break or jump back in.',
      actions: [
        FilledButton(onPressed: onResume, child: const Text('Resume')),
        OutlinedButton(onPressed: onRestart, child: const Text('Restart')),
        TextButton(onPressed: onExit, child: const Text('Exit')),
      ],
    );
  }
}

class OverlayCard extends StatelessWidget {
  const OverlayCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actions,
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0x77000000),
      child: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xEE0B1B2D),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0x44FFFFFF)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFB5CCE6)),
              ),
              const SizedBox(height: 18),
              ...actions.map((action) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: double.infinity, child: action),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
