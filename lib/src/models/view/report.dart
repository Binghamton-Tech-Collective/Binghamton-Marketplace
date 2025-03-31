import "package:btc_market/models.dart";

import "package:btc_market/data.dart";
import "package:btc_market/services.dart";

/// The view model for the report dialogue
class ReportViewModel extends ViewModel {
  /// Report reasons
  List<String> get reasons => Report.reasons;

  /// The selected report reason
  late String selectedReason = reasons.first;

  /// Additional comments from the user
  String comments = "";

  /// Type of item being reported
  final ReportType type;

  /// ID of the item being reported
  final String itemID;

  /// Creates a new view model from the given item
  ReportViewModel({required this.type, required this.itemID});

  /// Updates the report reason
  void updateReason(String? reason) {
    if (reason == null) return;
    selectedReason = reason;
    notifyListeners();
  }

  /// Updates the user's comments
  void updateComments(String? comments) {
    if (comments == null) return;
    this.comments = comments;
  }

  /// Submits the new report
  Future<void> submit() async {
    final report = Report(
      reason: selectedReason,
      comment: comments,
      author: services.auth.userID!,
      itemID: itemID,
      type: type,
      id: services.database.newReportID,
    );
    await services.database.saveReport(report);
  }
}
