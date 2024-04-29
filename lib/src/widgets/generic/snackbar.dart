import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// A custom snackbar after every event
class CustomSnackBar extends SnackBar {
  /// Text to be displayed in the snackbar
  final String text;
  /// The context of the page to display the Snackbar
  final BuildContext context;

  /// Constructor for the snackbar
  CustomSnackBar({required this.text, required this.context})
      : super(
          content: Text(text),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
}
