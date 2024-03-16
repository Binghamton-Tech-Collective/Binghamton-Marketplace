import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

/// The page to create or edit a seller profile.
class SellerProfileEditor extends ReactiveWidget<SellerProfileBuilder> {
  @override
  SellerProfileBuilder createModel() => SellerProfileBuilder();

  @override
  Widget build(BuildContext context, SellerProfileBuilder model) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
          title: const Text(
            "Create Seller Profile",
          ),
        ),
        // TODO: Check if you need a Center here
        body: Center(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => model.uploadImage(),
                child: ImageUploader(
                    imageUrl: model.imageUrl,
                    onDelete: () => model.deleteImage()),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: model.nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Who are you",
                      ),
                    ),
                  ],
                ),
              ),
              // TODO: Do we want major?
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Major",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextField(
                      // controller: model.,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "What are you studying",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bio",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: model.bioController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Tell us about yourself",
                      ),
                    ),
                  ],
                ),
              ),
              // TODO: Move social media editors into their own file for reuse
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Instagram",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: model.instagramController,
                      decoration: const InputDecoration(
                        prefixText: "@",
                        //labelText: "@",
                        border: OutlineInputBorder(),
                        hintText: "username",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (model.isSaving) const LinearProgressIndicator(),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: FilledButton(
                  // TODO: Check if we can get rid of this using standard themes
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 90, 67, 1)),
                  onPressed: model.isReady ? model.save : null,
                  child: const Text("Create Profile"),
                ),
              ),
              if (model.saveError != null)
                Text(
                  model.saveError!,
                  style: TextStyle(color: context.colorScheme.error),
                ),
              const SizedBox(height: 24),
              if (model.isSaving) const LinearProgressIndicator(),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: FilledButton(
                  // TODO: Check if we can get rid of this using standard themes
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
                  ),
                  onPressed: () => model.cancelProcess(),
                  child: const Text("Cancel"),
                ),
              ),
              if (model.errorText != null)
                Text(model.errorText!,
                    style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      );
}

/// Reusable image uploader widget
class ImageUploader extends StatelessWidget {
  /// Link to the image
  final String? imageUrl;

  /// A callback to run when the user presses "clear"
  final VoidCallback onDelete;

  /// Constructor to initialize the widget
  const ImageUploader({required this.imageUrl, required this.onDelete});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              child: Center(
                child: imageUrl == null
                    ? const Text(
                        "Upload an Image!",
                        textAlign: TextAlign.center,
                      )
                    : Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          if (imageUrl != null) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: onDelete,
              child: const Text("Clear"),
            ),
          ],
        ],
      );
}
