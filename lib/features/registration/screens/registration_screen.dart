import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:mobile_leckortung/core/widgets/radio.dart';

import '../../../core/widgets/email.dart';
import '../../../core/widgets/password.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _emailCcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Registrierung'),
      ),
      content: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: <Widget>[
                EmailAndText(
                  controller: _emailCcontroller,
                  isEmail: true,
                ),
                Password(controller: _passwordController),
                Password(
                  controller: _repasswordController,
                  label: 'Passwort wiederholen',
                  hint: 'Passwort wiederholen',
                ),
                RadioButton(
                  label: 'Ich stimme den Nutzungsbedingungen zu.',
                  description: '',
                  selected: false,
                ),
                FButton(onPress: () {}, label: Text('Registrieren'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
