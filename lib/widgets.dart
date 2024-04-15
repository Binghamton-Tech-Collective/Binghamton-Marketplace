import "package:flutter/material.dart";

export "package:go_router/go_router.dart";

export "src/widgets/atomic/category.dart";
export "src/widgets/atomic/conversation.dart";
export "src/widgets/atomic/message.dart";
export "src/widgets/atomic/product.dart";
export "src/widgets/atomic/seller_profile.dart";
export "src/widgets/atomic/social.dart";

export "src/widgets/generic/gallery.dart";
export "src/widgets/generic/storage_image.dart";
export "src/widgets/generic/image_upload.dart";
export "src/widgets/generic/reactive_widget.dart";
export "src/widgets/generic/spaced_row.dart";
export "src/widgets/generic/text_input.dart";
export "src/widgets/generic/profile.dart";

/// Convenience functions on [BuildContext].
extension BuildContextUtils on BuildContext {
	/// Gets the text theme of the app.
	TextTheme get textTheme => Theme.of(this).textTheme;

	/// Gets the color scheme of the app.
	ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Formats a date based on the user's locale.
  String formatDate(DateTime date) => MaterialLocalizations.of(this).formatCompactDate(date);

  /// Formats a time based on the user's locale.
  String formatTime(DateTime time) => MaterialLocalizations.of(this).formatTimeOfDay(
    TimeOfDay.fromDateTime(time),
  );

  /// Formats a date and time based on the user's locale.
  String formatDateAndTime(DateTime dateTime) => 
    "${formatDate(dateTime)}, ${formatTime(dateTime)}";
}
