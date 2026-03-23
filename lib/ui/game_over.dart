import 'package:flutter/material.dart';

import 'pause_menu.dart';

class ResultOverlay extends StatelessWidget {
  const ResultOverlay({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPrimary,
    required this.primaryLabel,
    required this.onExit,
  });

  final String title;
  final String subtitle;
  final VoidCallback onPrimary;
  final String primaryLabel;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return OverlayCard(
      title: title,
      subtitle: subtitle,
      actions: [
        FilledButton(onPressed: onPrimary, child: Text(primaryLabel)),
        TextButton(onPressed: onExit, child: const Text('Main Menu')),
      ],
    );
  }
}
