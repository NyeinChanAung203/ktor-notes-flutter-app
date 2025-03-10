import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

void showErrorDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Icon(
        Symbols.error_circle_rounded_rounded,
        color: Colors.redAccent,
        size: 40,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}
