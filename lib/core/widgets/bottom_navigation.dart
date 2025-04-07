import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class BottomNavigation extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChange;

  const BottomNavigation(
      {super.key, required this.index, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return FBottomNavigationBar(
      index: index,
      onChange: onChange,
      children: [
        FBottomNavigationBarItem(
          icon: FIcon(FAssets.icons.moonStar),
          label: const Text('Start'),
        ),
        FBottomNavigationBarItem(
          icon: FIcon(FAssets.icons.moonStar),
          label: const Text('Aufträge'),
        ),
        FBottomNavigationBarItem(
          icon: FIcon(FAssets.icons.search),
          label: const Text('Einstellungen'),
        ),
      ],
    );
  }
}
