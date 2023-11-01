import "package:flutter/material.dart";

export "src/widgets/reactive_widget.dart";

/// Convenience functions on [BuildContext].
extension BuildContextUtils on BuildContext {
	/// Gets the text theme of the app.
	TextTheme get textTheme => Theme.of(this).textTheme;

	/// Gets the color scheme of the app.
	ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
