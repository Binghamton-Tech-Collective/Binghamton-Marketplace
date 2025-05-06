import "package:btc_market/data.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// A button that triggers a [ReportDialogue] pop-up.
class ReportButton extends StatelessWidget {
  /// The type of item being reported.
  final ReportType type;

  /// The ID of the item being reported.
  final String itemID;

  /// What to have as the child of the [TextButton].  
  /// 
  /// This value defaults to a [Text] widget with a red "Report" string and a 20pt font size.  
  final Widget? child;

  /// Constructs a new report button widget.
  const ReportButton({required this.itemID, required this.type, this.child});

  /// Shows a dialogue to report an item.  
  Future<void> showReportForm(BuildContext context) => showDialog<void>(
    context: context,
    builder: (BuildContext context) => ReportDialogue(
      type: type,
      itemID: itemID,
    ),
  );

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () => showReportForm(context),
    child: child ?? const Text(
      "Report",
      style: TextStyle(
        color: Colors.red,
        fontSize: 20,
      ),
    ),
  );
}
