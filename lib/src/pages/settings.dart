import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";

/// The settings page.
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Settings"),
      actions: [ProfileButton()],
    ),
  );
}

// SizedBox(
//       width: 300,
//       child: FilterOption(
//         name: "Theme",
//         child: DropdownMenu(
//           initialSelection: model.theme,
//           onSelected: model.updateTheme,
//           dropdownMenuEntries: [
//             for (final theme in ThemeMode.values)
//               DropdownMenuEntry(value: theme, label: theme.displayName),
//           ],
//         ),
//       ),
//     ),
//     const SizedBox(height: 16),
