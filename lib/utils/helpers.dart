import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SaveRepository {
  static const String _unlockedKey = 'highest_unlocked_level';
  static const String _highScoreKey = 'high_score';

  Future<SaveData> load() async {
    final prefs = await SharedPreferences.getInstance();
    return SaveData(
      highestUnlockedLevel: prefs.getInt(_unlockedKey) ?? 1,
      highScore: prefs.getInt(_highScoreKey) ?? 0,
    );
  }

  Future<SaveData> saveProgress(SaveData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_unlockedKey, data.highestUnlockedLevel);
    await prefs.setInt(_highScoreKey, data.highScore);
    return data;
  }
}

double moveToward(double current, double target, double delta) {
  if (current < target) {
    return math.min(current + delta, target);
  }
  if (current > target) {
    return math.max(current - delta, target);
  }
  return target;
}
