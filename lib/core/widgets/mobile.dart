import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
class Mobile extends StatelessWidget {
  final String? label;
  final String? description;
  final String? hint;
  final TextEditingController controller;
  final bool isMobile;
  const Mobile({super.key, this.label, this.description, this.hint, required this.controller, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return FTextField(
      controller: controller,
      enabled: true,
      label: label != null ? Text(label!) : const Text('Rufnummer'),
      hint: '+49 0176 1234567',
      description: description != null ? Text(description!) : null,
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.none,
      maxLines: 1,
    );
  }
}
