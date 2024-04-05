import "package:flutter/material.dart";

class SpacedRow extends StatelessWidget {
  final Widget left;
  final Widget right;
  const SpacedRow(this.left, this.right);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [left, right],
  );
}
