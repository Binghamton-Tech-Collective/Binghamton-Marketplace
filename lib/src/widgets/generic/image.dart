import "dart:io";

import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:btc_market/widgets.dart";

import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";

/// Shows images from the [FilesService].
///
/// When testing, the service will use locally stored files, but otherwise
/// uses cloud firestore. This widget can determine which is being used and
/// delegates to the right widget to show the image.
class CircleFileImage extends StatelessWidget {
  /// The file to show.
  final FileHandle file;
  /// A const constructor.
  const CircleFileImage({required this.file});

  @override
  Widget build(BuildContext context) {
    final service = services.files;
    if (service is CloudStorageService) {
      final ref = service.toFirebase(file);
      return CircleStorageImage(ref: ref);
    } else {
      return CircleAvatar(
        backgroundImage: FileImage(File(file.path)),
      );
    }
  }
}

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
  ImageProvider? provider;

  @override
  Future<void> init() async {
    final url = allUrls[ref];
    if (url != null) {
      provider = NetworkImage(url);
      notifyListeners();
    } else {
      final url = await ref.getDownloadURL();
      allUrls[ref] = url;
      provider = NetworkImage(url);
      notifyListeners();
    }
  }
}

/// A widget to show an image in a [CircleAvatar], based on a Firebase [Reference].
class CircleStorageImage extends ReactiveWidget<StorageImageViewModel> {
  /// The [Reference] of the image.
  final Reference ref;

  /// Creates a circle widget with a Firebase image inside.
  CircleStorageImage({required this.ref}) : super(key: ValueKey(ref.fullPath));

  @override
  StorageImageViewModel createModel() => StorageImageViewModel(ref);

  @override
  Widget build(BuildContext context, StorageImageViewModel model) => CircleAvatar(
    backgroundImage: model.provider,
    child: model.provider == null ? const CircularProgressIndicator() : null,
  );
}
