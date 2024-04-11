import "package:flutter/material.dart";

import "package:btc_market/models.dart";

/// A widget that listens to a [ViewModel] (called the view model) and updates when it does. 
/// 
/// - If you're listening to an existing view model, use [ReusableReactiveWidget].
/// - If you're listening to a view model created by this widget, use [ReactiveWidget].
@immutable
abstract class ReactiveWidgetInterface<T extends ViewModel> extends StatefulWidget {
  /// A const constructor.
  const ReactiveWidgetInterface({super.key});
  /// Creates the view model. This is only called once in the widget's lifetime.
  T createModel();
  /// Whether this widget should dispose the model after it's destroyed. 
  /// 
  /// Normally, we want the widget to clean up after itself and dispose its view model. But it's
  /// also common for one view model to create and depend on another model. In this case, if we
  /// are listening to the sub-model, we don't want to dispose it while the parent model is still
  /// using it.
  bool get shouldDispose;

	@override
	ReactiveWidgetState createState() => ReactiveWidgetState<T>();

  /// Builds the UI according to the state in [model].
	Widget build(BuildContext context, T model);

  /// Builds the page when [ViewModel.errorText] is not null.
  Widget buildError(BuildContext context, T model) => Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Text("An error occurred:\n${model.errorText!}"),
    ),
  );

  /// Builds the page when [ViewModel.isLoading] is true.
  Widget buildLoading(BuildContext context, T model) => Scaffold(
    appBar: AppBar(),
    body: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  /// This function gives you an opportunity to update the view model when the widget updates. 
  /// 
  /// For more details, see [State.didUpdateWidget].
  @mustCallSuper
  void didUpdateWidget(covariant ReactiveWidgetInterface<T> oldWidget, T model) { }
}

/// A widget that listens to a [ViewModel] and rebuilds when the model updates.
abstract class ReactiveWidget<T extends ViewModel> extends ReactiveWidgetInterface<T> {
	/// A const constructor.
	const ReactiveWidget({super.key});

	/// A function to create or find the model. This function will only be called once.
  @override
	T createModel();

  @override
  bool get shouldDispose => true;
}

/// A [ReactiveWidgetInterface] that "borrows" a view model and does not dispose of it. 
abstract class ReusableReactiveWidget<T extends ViewModel> extends ReactiveWidgetInterface<T> {
  /// The model to borrow.
  final T model;
  /// A const constructor.
  const ReusableReactiveWidget(this.model);

  @override
  T createModel() => model;

  @override
  bool get shouldDispose => false;
}

/// A state for [ReactiveWidget] that manages the [model].
class ReactiveWidgetState<T extends ViewModel> extends State<ReactiveWidgetInterface<T>>{
	/// The model to listen to.
	late final T model;

	@override
	void initState() {
		super.initState();
		model = widget.createModel();
		model.addListener(listener);
	}

	@override
	void dispose() {
		model.removeListener(listener);
    if (widget.shouldDispose) model.dispose();
		super.dispose();
	}

  @override
  void didUpdateWidget(covariant ReactiveWidgetInterface<T> oldWidget) {
    widget.didUpdateWidget(oldWidget, model);
    super.didUpdateWidget(oldWidget);
  }

	/// Updates the UI when [model] updates.
	void listener() => setState(() {});

	@override
	Widget build(BuildContext context) => model.errorText != null
    ? widget.buildError(context, model) : model.isLoading
      ? widget.buildLoading(context, model) : widget.build(context, model);
}
