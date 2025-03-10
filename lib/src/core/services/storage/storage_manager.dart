import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_template/src/features/auth/domain/token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'preferences.dart';

part 'storage_manager.g.dart';

@riverpod
IStorageManager storageManager(Ref ref) {
  return Preferences();
}

abstract class IStorageManager {
  Future<void> saveToken(Token token);
  Future<Token?> getToken();
  Future<void> clearToken();
  Future<void> saveLocale(String languageCode);
  Future<String?> getLocale();
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}
