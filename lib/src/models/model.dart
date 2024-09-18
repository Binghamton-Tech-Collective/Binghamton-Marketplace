import "package:flutter/foundation.dart";
export "package:flutter/foundation.dart" show ChangeNotifier;

import "package:btc_market/data.dart";

/// A [ChangeNotifier] that contains data and can be listened to.
/// 
/// No work should occur until [init] is called. This method is called differently based on the
/// type of model: [DataModel]s require it to be called explicitly, as they have longer load times
/// and load crucial data for the rest of the app. [ViewModel]s call it right away, but don't await
/// the futures, so that the UI can render right away while other data loads in the background.
abstract class Model with ChangeNotifier {
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

/// A model to load and manage state needed by any piece of UI.
/// 
/// [init] is called right away but unlike [DataModel]s, it is *not* awaited. Use [isLoading] and 
/// [errorText] to convey progress to the user. This allows the UI to load immediately.
abstract class ViewModel extends Model {
	/// Calls [init] right away but does not await it.
	ViewModel() { init(); }
}

/// A model containing data needed throughout the app.
/// 
/// This model may need to be initialized, so [init] should be called before using it. This model
/// should also be held as a singleton in some global scope. [dispose] can be overriden to clean up
/// any resources used by this model.
abstract class DataModel extends Model {
  /// A callback to run when the user signs in.
  Future<void> onSignIn(UserProfile profile);
  /// A callback to run when the user signs out.
  Future<void> onSignOut();
}

/// A model to build a value from the UI.
abstract class BuilderModel<T> extends ViewModel {
	/// The value being edited.
	T build();

	/// Whether the value of [build] is ready to be accessed.
	bool get isReady;
}
