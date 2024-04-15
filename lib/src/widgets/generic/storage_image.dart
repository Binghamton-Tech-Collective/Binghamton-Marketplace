import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";

/// A view model to load an image from Firebase.
class StorageImageViewModel extends ViewModel {
  /// A cache of all the URLs that have been loaded in the past.
  /// 
  /// Without this cache, rebuilding the widget would cause the view model to reload the URL from
  /// the network. With this, the image can be kept in memory since Flutter knows the URL already.
  static final Map<Reference, String> allUrls = {};
  
  /// The Firebase Cloud Storage reference of this image.
  final Reference ref;

  /// Creates a view model to load an image from a [Reference].
  StorageImageViewModel(this.ref);

  /// The loaded URL. This is null before its loaded.
  String? url;

  @override
  Future<void> init() async {
    if (allUrls.containsKey(ref)) {
      url = allUrls[ref];
      notifyListeners();
    } else {
      url = await ref.getDownloadURL();
      allUrls[ref] = url!;
      notifyListeners();
    }
  }
}

/// A widget to show an image in a [CircleAvatar], based on a Firebase [Reference].
class CircleStorageImage extends ReactiveWidget<StorageImageViewModel> {
  /// The [Reference] of the image.
  final Reference ref;
  /// The radius of the [CircleAvatar].
  final double? radius;
  /// Creates a circle widget with a Firebase image inside.
  CircleStorageImage({required this.ref, this.radius}) : super(key: ValueKey(ref.fullPath));

  @override
  StorageImageViewModel createModel() => StorageImageViewModel(ref);

  @override
  Widget build(BuildContext context, StorageImageViewModel model) => CircleAvatar(
    radius: radius,
    backgroundImage: model.url == null ? null : NetworkImage(model.url!),
    child: model.url == null ? const CircularProgressIndicator() : null,
  );
}
