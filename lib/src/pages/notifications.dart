import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";

/// The notifications page.
class NotificationsPage extends ReactiveWidget<NotificationViewModel>{
  @override
  NotificationViewModel createModel() => NotificationViewModel();

  @override
  Widget build(BuildContext context, NotificationViewModel model) => Scaffold(
    body: Container(
      color: Colors.blue,
      height: 100,
      width: 500,
    ),
  );
}
