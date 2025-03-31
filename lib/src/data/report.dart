import "package:btc_market/data.dart";

/// The type of item to be reported.
enum ReportType {
  /// A product being sold
  product,
  /// A conversation between buyer and seller
  conversation,
  /// A user's profile. This isn't actually being used,
  /// but we keep it here in case
  userProfile,
  /// A seller's profile
  sellerProfile;

  /// Method to convert a ReportType variant to a string
  /// for serialization
  String toJson() => switch (this) {
    product => "product",
    conversation => "conversation",
    sellerProfile => "seller",
    userProfile => "user",
  };

  factory ReportType.fromJson(String s) => switch (s) {
    "product" => product,
    "conversation" => conversation,
    "seller" => sellerProfile,
    "user" => userProfile,
    _ => throw FormatException("Unrecognized ItemType: $s"),
  };
}

/// A general purpose report
class Report {
  /// A list of reasons for reporting an item
  static final reasons = [
    "Other",
    "Innappropriate",
    "Offensive",
    "Fradulent",
  ];

  /// The ID of the user who sent this report
  final UserID author;
  /// The reason for the report
  final String reason;
  /// Any additional comments from the user
  final String comment;
  /// The time the report was sent
  final DateTime timeSent;
  /// The ID of the item reported. Type of ID depends on the ItemType
  final String itemID;
  /// The ID of the report
  final ReportID id;
  /// The type of item this report is targeting
  final ReportType type;

  /// A constructor to create a new report
  Report({
    required this.author,
    required this.reason,
    required this.comment,
    required this.itemID,
    required this.type,
    required this.id,
  }) : timeSent = DateTime.now();

  /// Creates a new Report object from a JSON object.
  Report.fromJson(Json json) :
    author = json["author"],
    reason = json["reason"],
    comment = json["comment"],
    timeSent = DateTime.parse(json["timeSent"]),
    itemID = json["itemID"],
    id = json["id"],
    type = ReportType.fromJson(json["type"]);

  /// Convert this Report to its JSON representation
  Json toJson() => {
    "author": author,
    "reason": reason,
    "comment": comment,
    "timeSent": timeSent.toIso8601String(),
    "itemID": itemID,
    "id": id,
    "type": type.toString(),
  };
}
