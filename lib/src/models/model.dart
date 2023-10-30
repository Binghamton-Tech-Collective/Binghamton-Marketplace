import "package:flutter/foundation.dart";
export "package:flutter/foundation.dart" show ChangeNotifier;

/// A model containing data needed throughout the app.
/// 
/// This model may need to be initialized, so [init] should be called before using it. This model
/// should also be held as a singleton in some global scope. [dispose] can be overriden to clean up
/// any resources used by this model.
abstract class DataModel with ChangeNotifier {
	/// Initializes any data needed by the model.
	Future<void> init();
}

/// A model to build a value from the UI.
abstract class BuilderModel<T> with ChangeNotifier {
	/// The value being edited.
	T get value;

	/// Whether the [value] is ready to be accessed.
	bool get isReady;
}

/// A model to load and manage state needed by any piece of UI.
/// 
/// [init] is called right away but unlike [DataModel]s, it is *not* awaited. Use [isLoading] and 
/// [errorText] to convey progress to the user. This allows the UI to load immediately.
abstract class ViewModel with ChangeNotifier {
	/// Calls [init] right away but does not await it.
	ViewModel() { init(); }

	bool _isLoading = false;
	String? _errorText;

	/// Whether this model is currently loading data. Setting this updates the UI.
	bool get isLoading => _isLoading;
	set isLoading(bool value) {
		_isLoading = value;
		notifyListeners();
	}

	/// Whether this model has encountered an error. Setting this updates the UI.
	String? get errorText => _errorText;
	set errorText(String? value) {
		_errorText = value;
		notifyListeners();
	}

	/// Override this method to initializes any data needed by the model.
	Future<void> init() async { }
}
