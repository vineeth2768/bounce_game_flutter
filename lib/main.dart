import 'package:flutter/material.dart';

import 'audio/audio_manager.dart';
import 'game/bounce_game.dart';
import 'ui/hud.dart';
import 'ui/level_select.dart';
import 'ui/main_menu.dart';
import 'utils/constants.dart';
import 'utils/helpers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BounceApp());
}

enum AppView { loading, menu, levels, game }

class BounceApp extends StatelessWidget {
  const BounceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bounce Web',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD62839),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF07111F),
        useMaterial3: true,
      ),
      home: const BounceShell(),
    );
  }
}

class BounceShell extends StatefulWidget {
  const BounceShell({super.key});

  @override
  State<BounceShell> createState() => _BounceShellState();
}

class _BounceShellState extends State<BounceShell> {
  final SaveRepository _saveRepository = SaveRepository();
  final AudioManager _audioManager = AudioManager();

  AppView _view = AppView.loading;
  SaveData _saveData = const SaveData(highestUnlockedLevel: 1, highScore: 0);
  BounceGame? _game;

  @override
  void initState() {
    super.initState();
    _loadSaveData();
  }

  Future<void> _loadSaveData() async {
    final data = await _saveRepository.load();
    if (!mounted) {
      return;
    }
    setState(() {
      _saveData = data;
      _view = AppView.menu;
    });
  }

  Future<void> _updateSaveData(SaveData data) async {
    final saved = await _saveRepository.saveProgress(data);
    if (!mounted) {
      return;
    }
    setState(() {
      _saveData = saved;
    });
  }

  void _startGame({int level = 1}) {
    _game?.onDispose();
    setState(() {
      _game = BounceGame(
        audio: _audioManager,
        initialSaveData: _saveData,
        initialLevel: level,
        onSaveDataChanged: (data) {
          _updateSaveData(data);
        },
      );
      _view = AppView.game;
    });
  }

  void _exitToMenu() {
    _game?.onDispose();
    setState(() {
      _game = null;
      _view = AppView.menu;
    });
  }

  @override
  void dispose() {
    _game?.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_view) {
      case AppView.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AppView.menu:
        return MainMenuScreen(
          highScore: _saveData.highScore,
          highestUnlockedLevel: _saveData.highestUnlockedLevel,
          onPlay: _startGame,
          onLevelSelect: () => setState(() => _view = AppView.levels),
        );
      case AppView.levels:
        return LevelSelectScreen(
          highestUnlockedLevel: _saveData.highestUnlockedLevel,
          onBack: () => setState(() => _view = AppView.menu),
          onSelectLevel: (level) => _startGame(level: level),
        );
      case AppView.game:
        return Scaffold(
          body: GameStage(
            game: _game!,
            onExitToMenu: _exitToMenu,
          ),
        );
    }
  }
}
