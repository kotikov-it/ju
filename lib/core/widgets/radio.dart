import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class RadioButton extends StatelessWidget {
  final void Function(bool)? onChange;
  final String label;
  final String description;
  final String? errorMessage;
  final bool selected;

  const RadioButton(
      {super.key,
      this.onChange,
      required this.label,
      required this.description,
      this.errorMessage,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: false,
      validator: (value) =>
          (value ?? false) ? null : 'Please accept the terms and conditions.',
      builder: (state) => FCheckbox(
        label: const Text('Accept terms and conditions'),
        description: const Text('You agree to our terms and conditions.'),
        error: state.errorText != null ? Text(state.errorText!) : null,
        value: state.value ?? false,
        onChange: (value) => state.didChange(value),
      ),
    );
  }
}
