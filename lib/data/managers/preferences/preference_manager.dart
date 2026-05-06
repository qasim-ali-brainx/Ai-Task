import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  PreferenceManager(this._preferences);

  final SharedPreferences _preferences;

  static const String _lastBriefTextKey = 'last_brief_text';

  Future<void> saveLastBrief(String value) async {
    await _preferences.setString(_lastBriefTextKey, value);
  }

  String? getLastBrief() => _preferences.getString(_lastBriefTextKey);
}
