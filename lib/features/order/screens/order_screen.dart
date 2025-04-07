import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class OrderScreen extends StatelessWidget {
  final String title;
  final List<dynamic> orders;

  const OrderScreen({super.key, required this.title, required this.orders});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Text(
            'Diese Seite verfügt über keine Aufträge',
            style: textTheme.headlineSmall, // Passende Textgröße
            textAlign: TextAlign.center,
          ),
          Text(
            'Es wurden bis jetzt keine Aufträge erstellt. Um einen Auftrag zu erstellen, klicken Sie auf den Button.',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant, // Etwas dezentere Farbe
            ),
            textAlign: TextAlign.center,
          ),
          FButton(onPress: () {}, label: Text('Hinzufügen'))
        ],
      ),
    );
  }
}
