import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      // showErrorDialog(context, ErrorHandler.getErrorMessage(error));
    }
  }

  void showToastOnError() {
    if (!isLoading && hasError) {
      // showToast(ErrorHandler.getErrorMessage(error));
    }
  }
}
