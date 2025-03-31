import "package:btc_market/src/data/report.dart";
import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";
import "package:flutter/material.dart";

/// A report form.
/// Should be used as the content of an AlertDialogue.
class ReportDialogue extends ReactiveWidget<ReportViewModel> {
  /// The type of item being reported
  final ReportType type;

  /// The ID of the item being reported
  final String itemID;

  /// Constructs a new report dialogue widget
  const ReportDialogue({required this.type, required this.itemID, super.key});

  @override
  ReportViewModel createModel() => ReportViewModel(type: type, itemID: itemID);

  @override
  Widget build(BuildContext context, ReportViewModel model) => AlertDialog(
    title: Text("Report this ${model.type.toJson()}"),
    content: SizedBox(
      width: 300,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          LabelledOption(
            name: "Reason",
            child: DropdownButton<String>(
              value: model.selectedReason,
              icon: const Icon(Icons.arrow_drop_down),
              items: [
                for (final choice in Report.reasons) DropdownMenuItem(
                  value: choice,
                  child: Text(choice),
                ),
              ],
              onChanged: model.updateReason,
            ),
          ),
          TextField(
            maxLines: 2,
            onChanged: model.updateComments,
            decoration: const InputDecoration(
              labelText: "Comments",
            ),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text("Cancel"),
        onPressed: () => context.pop(),
      ),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Submit"),
        onPressed: () async {
          await model.submit();
          if (!context.mounted) return;
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
