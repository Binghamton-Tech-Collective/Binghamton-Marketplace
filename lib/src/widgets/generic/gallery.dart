import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// A view model to support [GalleryWidget].
class GalleryViewModel extends ViewModel {
  /// The product being shown off.
  final Product product;
  
  /// THe number of pages being displayed.
  int get numPages => product.imageUrls.length;

  /// The duration for the page transition animation.
  final Duration duration;

  /// The curve for the page transition animation.
  final Curve curve;
  
  /// The Flutter [PageView] controller. 
  final controller = PageController();
  
  /// Creates a view model to show a [GalleryWidget].
  GalleryViewModel({
    required this.product,
    this.duration = const Duration(milliseconds: 250), 
    this.curve = Curves.easeInOut,
  });

  /// The current page.
  int page = 0;

  /// Updates the page index.
  void updatePage(int index) {
    page = index;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Animates to the next page.
  void next() {
    page++;
    if (page == numPages) page--;
    controller.animateToPage(page, duration: duration, curve: curve);
    notifyListeners();
  }

  /// Animates to the previous page.
  void prev() {
    page--;
    if (page == -1) page++;
    controller.animateToPage(page, duration: duration, curve: curve);
    notifyListeners();
  }
}

/// A widget that allows swiping through images in a gallery.
class GalleryWidget extends ReactiveWidget<GalleryViewModel> {
  /// The product being shown off.
  final Product product;
  /// Creates a gallery widget.
  const GalleryWidget({required this.product, super.key});

  @override
  GalleryViewModel createModel() => GalleryViewModel(product: product);

  @override
  Widget build(BuildContext context, GalleryViewModel model) => Stack(
    alignment: Alignment.center,
    children: [
      Positioned.fill(
        child: PageView(
          onPageChanged: model.updatePage,
          controller: model.controller,
          children: [
            for (final (index, imageUrl) in model.product.imageUrls.enumerate) Hero(
              tag: "${product.id}-image-$index",
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
      Positioned(
        left: 12,
        child: IconButton.filled(
          icon: const Icon(Icons.arrow_circle_left, size: 36),
          onPressed: model.page == 0 ? null : model.prev,
          style: IconButton.styleFrom(backgroundColor: context.colorScheme.primary, disabledBackgroundColor: context.colorScheme.primary),
        ),
      ),
      Positioned(
        right: 12,
        child: IconButton.filled(
          icon: const Icon(Icons.arrow_circle_right, size: 36),
          onPressed: model.page == (model.numPages - 1) ? null : model.next,
          style: IconButton.styleFrom(backgroundColor: context.colorScheme.primary, disabledBackgroundColor: context.colorScheme.primary),
        ),
      ),
    ],
  );
}
