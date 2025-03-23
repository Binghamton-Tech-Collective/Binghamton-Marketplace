import "package:btc_market/services.dart";
import "package:btc_market/src/data/report.dart";
import "package:flutter/material.dart";

/// A report form.  
/// Should be used as the content of an AlertDialogue.  
class ReportDialogue extends StatefulWidget {
  /// The type of item being reported
  final ItemType itemType;

  /// The ID of the item being reported
  final String itemID;

  /// Constructs a new report dialogue widget
  const ReportDialogue({required this.itemType, required this.itemID, super.key});

  @override
  State<ReportDialogue> createState() => _ReportDialogueState();
}

/// A bunch of reasons that will appear on the dropdown menu,
final reportReasons = [
  "Other",
  "Inappropriate/NSFW",
];

/// These ones depends on the type of item being reported
final specificReportReasons = [
  (
    reason: "Troll", 
    applicableTypes: [
      ItemType.product, 
      ItemType.sellerProfile, 
      ItemType.userProfile,
    ]
  ),
  (
    reason: "Fraudulent activity", 
    applicableTypes: [
      ItemType.userProfile, 
      ItemType.sellerProfile,
    ]
  ),
  (
    reason: "Disrespectful", 
    applicableTypes: [
      ItemType.userProfile, 
      ItemType.sellerProfile,
      ItemType.conversation,
    ]
  ),
];

class _ReportDialogueState extends State<ReportDialogue> {
  final TextEditingController _textController = TextEditingController();
  late String selectedReason;
  late final List<String> choices;

  @override
  void initState() {
    super.initState();
    
    choices = [
      ...reportReasons, 
      ...specificReportReasons
        .where((record) => record.applicableTypes.contains(widget.itemType))
        .map((record) => record.reason),
    ];
    
    selectedReason = choices.first;
  }

  Future<void> submit() {
    final report = Report(
      reason: selectedReason,
      comment: _textController.text,
      author: services.auth.userID!,
      itemID: widget.itemID,
      type: widget.itemType,
      id: services.database.reports.newID,
    );
    
    return services.database.saveReport(report);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text("Report this ${widget.itemType}"),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          DropdownButton<String>(
            value: selectedReason,
            items: choices.map(
              (reason) => DropdownMenuItem<String>(
                value: reason,
                child: Text(reason),
              ),
            ).toList(),
            onChanged: (newVal) { 
              setState(() {
                selectedReason = newVal!; 
              });
            },
          ),
          TextField(
            maxLines: 2,
            controller: _textController,
            decoration: const InputDecoration(
              labelText: "Comments",
            ),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text("Submit"),
        onPressed: () {
          submit().whenComplete(
            () {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          );
        },
      ),
    ],
  );
}
