import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

void showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Icon(
        Symbols.exit_to_app_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      content: Text(
        'Are you sure you want to exit?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancel')),
        FilledButton(
            onPressed: () {
              exit(1);
            },
            child: const Text('Exit')),
      ],
    ),
  );
}
