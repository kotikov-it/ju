import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_leckortung/core/navigation/routes.dart';

import '../../../core/widgets/email.dart';

class LicenseKeyScreen extends StatelessWidget {
  final TextEditingController _licenseController = TextEditingController();

  LicenseKeyScreen({super.key});

  void _showLicenseDialog(BuildContext context) {
    showAdaptiveDialog(
        context: context,
        builder: (context) => FDialog(
              direction: Axis.horizontal,
              title: const Text('Fehler'),
              body: const Text(
                  'Wir konnte Ihre Lizenz nicht finden. Bitte versuchen Sie es erneut oder beauftragen Sie eine Lizenz.'),
              actions: [
                FButton(
                    style: FButtonStyle.outline,
                    label: const Text('Zurück'),
                    onPress: () => Navigator.of(context).pop()),
                FButton(
                    label: const Text('Beauftragen'),
                    onPress: () => context.push(AppRoutes.licenseRequest)),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Implement dialog for license
    return FScaffold(
      header: FHeader(
        title: const Text('Lizenz'),
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
                /*
                * Nano IDs are typically around 21 characters long.
                * **/
                EmailAndText(
                  controller: _licenseController,
                  label: 'Lizenz',
                  hint: 'Beispiel: V1StGXR8_Z5jdHi6B-myT',
                  description:
                      'Bitte geben Sie Ihre Lizenz ein. Die Lizenz besteht aus 21 Zeichen.',
                  isEmail: false,
                ),
                FButton(onPress: () => _showLicenseDialog(context), label: Text('Lizenz abfragen'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
