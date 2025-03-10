import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FilledAsyncButton extends StatelessWidget {
  const FilledAsyncButton(
      {super.key,
      required this.isLoading,
      required this.onPressed,
      required this.text});
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 28,
                width: 28,
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                ),
              )
            : Text(text),
      ),
    );
  }
}
