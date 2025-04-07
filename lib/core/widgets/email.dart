import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class EmailAndText extends StatelessWidget {
  final String? label;
  final String? description;
  final String? hint;
  final TextEditingController controller;
  final bool isEmail;

  const EmailAndText(
      {super.key,
      required this.controller,
      this.label,
      this.description,
      required this.isEmail,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return isEmail
        ? FTextField.email(
            controller: controller,
            enabled: true,
            label: label != null ? Text(label!) : const Text('Email'),
            hint: 'max.mustermann@muster.de',
            description: description != null ? Text(description!) : null,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          )
        : FTextField(
            controller: controller,
            enabled: true,
            label: label != null ? Text(label!) : const Text('Email'),
            hint: hint,
            description: description != null ? Text(description!) : null,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          );
  }
}
