import "package:btc_market/pages.dart";
import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The settings page.
class SettingsPage extends ReactiveWidget<SettingsViewModel> {
  @override
  SettingsViewModel createModel() => SettingsViewModel();

  @override
  Widget build(BuildContext context, SettingsViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Settings"),
      actions: [ProfileButton()],
      leading: router.canPop() ? null : IconButton(
        icon: const Icon(Icons.home),
        tooltip: "Go home",
        onPressed: () => router.go(Routes.products),
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              LabelledOption(
                name: "Theme",
                child: DropdownMenu(
                  initialSelection: model.theme,
                  onSelected: model.updateTheme,
                  dropdownMenuEntries: [
                    for (final theme in ThemeMode.values)
                      DropdownMenuEntry(value: theme, label: theme.displayName),
                  ],
                ),
              ),
              if (model.hasNotificationPermission) const ListTile(
                title: Text("Notifications"),
                subtitle: Text("You have granted notification permissions"),
              ) else if (model.requestedPermission) const ListTile(
                title: Text("Notifications"),
                subtitle: Text("You have denied notification permissions\nTo grant access, check your browser or app settings"),
                isThreeLine: true,
              )
              else ListTile(
                title: const Text("Notifications"),
                subtitle: const Text("Tap or click to grant permission"),
                onTap: model.requestNotificationPermission,
              ),
            ],
          ),
        ),
        OverflowBar(
          alignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 4),
            FilledButton(
              onPressed: () async {
                await model.save();
                if (context.mounted) context.pop();
              },
              child: const Text("Save"),
            ),
            const SizedBox(width: 4),
          ],
        ),
        const SizedBox(height: 4),
      ],
    ),
  );
}
