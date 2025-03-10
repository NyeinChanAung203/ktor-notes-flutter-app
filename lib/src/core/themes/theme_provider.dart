import 'package:flutter/material.dart';
import 'package:my_template/src/core/services/storage/storage_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeProvider extends _$ThemeProvider {
  @override
  ThemeMode build() {
    _getCurrentTheme();
    return ThemeMode.system;
  }

  void _getCurrentTheme() async {
    try {
      final theme = await ref.read(storageManagerProvider).getThemeMode();
      state = theme;
    } catch (_) {
      state = ThemeMode.system;
    }
  }
}
