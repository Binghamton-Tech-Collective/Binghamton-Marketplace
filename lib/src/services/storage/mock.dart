import "dart:math";

import "package:btc_market/data.dart";
import "interface.dart";

/// An implementation of [FilesService] that always returns URLs to random images.
class MockFilesService extends FilesService {
  static final _random = Random();

  @override
  Future<void> init() async { }

  @override
  Future<String?> uploadFile(Uint8List data, FileHandle reference) async {
    final size = _random.nextInt(200) + 200;  // [200, 400]
    return "https://picsum.photos/$size";
  }

  @override
  Future<void> deleteFile(String path) async { }

  @override
  Future<void> deleteSellerProfile(SellerID id) async { }

  @override
  Future<void> deleteProduct(ProductID id) async { }

  @override
  FileHandle getSellerImagePath(SellerID id) => FileHandle(mockSeller.imageUrl);

  @override
  FileHandle getProductImage(ProductID id, int index) => FileHandle(mockProduct.imageUrls[index]);

  @override
  FileHandle getUserImagePath(UserID id) => FileHandle(mockUser.imageUrl);
}
