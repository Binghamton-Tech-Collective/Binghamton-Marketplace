import "package:flutter/material.dart";

/// A widget that prompts the user for an image then uploads and displays it.
class ImageUploader extends StatelessWidget {
  /// Link to the image
  final String? imageUrl;

  /// A callback to run when the user taps the image.
  final VoidCallback onTap;

  /// A callback to run when the user presses "clear"
  final VoidCallback onDelete;
  
  /// Constructor to initialize the widget
  const ImageUploader({
    required this.imageUrl, 
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: imageUrl == null
                ? const Text(
                  "Upload an Image!",
                  textAlign: TextAlign.center,
                ) : Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                ),
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
