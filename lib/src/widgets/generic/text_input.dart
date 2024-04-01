import "package:flutter/material.dart";
import "package:flutter/services.dart";

/// Reusable InputContainer for input fields
class InputContainer extends StatelessWidget {
  /// The title of this input container.
  final String text;

  /// Hint to be entered for the input
  final String hint;

  /// Controller available in the model
  final TextEditingController controller;

  /// The formatter for this text field, if any.
  final TextInputFormatter? formatter;

  /// The keyboard type for this input, if not the default.
  final TextInputType? inputType;

  /// The error with this input, if any.
  final String? errorText;

  /// A prefix string to show in front of the user's input.
  final String? prefixText;

  /// Constructor to set the fields
  const InputContainer({
    required this.text,
    required this.hint,
    required this.controller,
    this.formatter,
    this.inputType,
    this.errorText,
    this.prefixText,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      TextField(
        controller: controller,
        inputFormatters: [
          if (formatter != null) formatter!,
        ],
        keyboardType: inputType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          errorText: errorText,
          prefixText: prefixText,
        ),
      ),
      const SizedBox(height: 12),
    ],
  );
}
