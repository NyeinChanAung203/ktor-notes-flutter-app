import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_template/src/features/auth/domain/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_manager.dart';

class Preferences implements IStorageManager {
  static const String _accessToken = 'accessToken';
  static const String _refreshToken = 'refreshToken';
  static const String _expiredAt = 'expiredAt';
  static const String _locale = 'locale';
  static const String _themeMode = 'themeMode';

  @override
  Future<void> saveToken(Token token) async {
    final pref = await SharedPreferences.getInstance();
    await Future.wait([
      pref.setString(_accessToken, token.accessToken),
      pref.setString(_refreshToken, token.refreshToken),
      pref.setString(_expiredAt, token.expiredAt),
    ]);
    log('savedToken');
  }

  @override
  Future<Token?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString(_accessToken);
    final refreshToken = pref.getString(_refreshToken);
    final expiredAt = pref.getString(_expiredAt);
    if (accessToken == null || refreshToken == null || expiredAt == null) {
      return null;
    }
    return Token(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiredAt: expiredAt);
  }

  @override
  Future<void> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(_accessToken);
    log('clearToken');
  }

  @override
  Future<void> saveLocale(String languageCode) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_locale, languageCode);
    log('savedlocale');
  }

  @override
  Future<String?> getLocale() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_locale);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final pref = await SharedPreferences.getInstance();
    final themeMode = pref.getString(_themeMode);
    return ThemeMode.values.firstWhere(
        (t) => t.name.toLowerCase() == themeMode?.toLowerCase(),
        orElse: () => ThemeMode.system);
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_themeMode, themeMode.name);
    log('savedTheme');
  }
}
