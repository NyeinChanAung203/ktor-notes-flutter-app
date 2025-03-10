import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_template/src/core/extensions/extensions.dart';
import 'package:my_template/src/core/services/storage/storage_manager.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'localization.g.dart';

abstract class Localization {
  static final all = [
    const Locale('my'),
    const Locale('en'),
  ];

  static String getLanguage(BuildContext context, String code) {
    switch (code) {
      case "my":
        return context.locale.myanmar;
      case "en":
      default:
        return context.locale.english;
    }
  }

  static showLanguageDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${context.locale.select} ${context.locale.language}"),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ListTile(
              //   leading: Flag(Flags.united_kingdom),
              //   title: Text(context.locale.english),
              //   onTap: () {
              //     ref
              //         .read(localeProviderProvider.notifier)
              //         .setLocal(const Locale('en'));
              //     context.pop();
              //   },
              // ),
              // ListTile(
              //   leading: Flag(Flags.myanmar),
              //   title: Text(context.locale.myanmar),
              //   onTap: () {
              //     ref
              //         .read(localeProviderProvider.notifier)
              //         .setLocal(const Locale('my'));
              //     context.pop();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

@riverpod
class LocaleProvider extends _$LocaleProvider {
  @override
  Locale build() {
    _onAppStart();
    return const Locale('en');
  }

  void setLocal(Locale locale) async {
    try {
      await ref.read(storageManagerProvider).saveLocale(locale.languageCode);
      state = Locale(locale.languageCode);
    } catch (error) {
      state = const Locale('en');
    }
  }

  void _onAppStart() async {
    try {
      final code = await ref.read(storageManagerProvider).getLocale();
      state = Locale(code ?? 'en');
    } catch (error) {
      state = const Locale('en');
    }
  }
}
