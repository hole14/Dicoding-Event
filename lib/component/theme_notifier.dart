import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier{
  static const String prefMode = "isDarkMode";
  static const String prefNotif = "isNotificationOn";

  bool _isDarkMode = false;
  bool _isNotificationOn = false;

  bool get isDarkMode => _isDarkMode;
  bool get isNotificationOn => _isNotificationOn;

  ThemeNotifier(){
    _loadSetting();
  }

  Future<void> _loadSetting() async{
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(prefMode) ?? false;
    _isNotificationOn = prefs.getBool(prefNotif) ?? true;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async{
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefMode, value);
    notifyListeners();
  }

  Future<void> setNotification(bool value) async {
    _isNotificationOn = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefNotif, value);
    notifyListeners();
  }

  void toggleDarkMode(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleNotification(){
    _isNotificationOn = !_isNotificationOn;
    notifyListeners();
  }

}