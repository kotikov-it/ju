import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Password extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? description;
  final String? hint;

  const Password({super.key, required this.controller, this.label, this.description, this.hint});

  @override
  Widget build(BuildContext context) {
    return FTextField.password(
      controller: controller,
      // TextEditingController
      enabled: true,
      textInputAction: TextInputAction.done,
      label: label != null ? Text(label!) : const Text('Passwort'),
      hint: hint != null ? hint! : 'Passwort eingeben',
      description: description != null ? Text(description!) : null,
      textCapitalization: TextCapitalization.none,
      maxLines: 1,
    );
  }
}
