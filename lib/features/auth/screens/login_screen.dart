import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:mobile_leckortung/core/widgets/email.dart';
import 'package:mobile_leckortung/core/widgets/password.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailCcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgets übernehmen Stile aus AppTheme
    return FScaffold(
      header: FHeader(
        title: const Text('Login'),
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
                EmailAndText(controller: _emailCcontroller, isEmail: true,),
                Password(controller: _passwordController),
                FButton(onPress: () {}, label: Text('Anmelden'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
