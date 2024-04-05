import "package:flutter/material.dart";

/// A very simple widget when you need one child on the left and one on the right.
class SpacedRow extends StatelessWidget {
  /// The left widget.
  final Widget left;
  /// The right widget.
  final Widget right;
  /// Creates a row with each element on the sides.
  const SpacedRow(this.left, this.right);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [left, right],
  );
}
