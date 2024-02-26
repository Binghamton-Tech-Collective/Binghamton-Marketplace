import "package:flutter/material.dart";

export "package:go_router/go_router.dart";

export "src/widgets/atomic/product.dart";
export "src/widgets/atomic/seller_profile.dart";

export "src/widgets/generic/gallery.dart";
export "src/widgets/generic/reactive_widget.dart";

/// Convenience functions on [BuildContext].
extension BuildContextUtils on BuildContext {
	/// Gets the text theme of the app.
	TextTheme get textTheme => Theme.of(this).textTheme;

	/// Gets the color scheme of the app.
	ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
