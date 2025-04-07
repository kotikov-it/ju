import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:mobile_leckortung/core/navigation/routes.dart';
import 'package:mobile_leckortung/core/widgets/mobile.dart';

import '../../../core/widgets/email.dart';
import '../../../core/widgets/menu_select.dart';

enum Salutation {
  // Definiert die Enum-Werte und übergibt den Anzeigetitel an den Konstruktor.
  mr('Herr'),
  ms('Frau'),
  diverse('Divers'); // Repräsentiert "Andere" oder nicht-binäre Optionen

  /// Der lesbare Titel für die Anrede (z.B. zur Anzeige in UI-Elementen).
  final String displayTitle;

  /// Konstanter Konstruktor für das Enum.
  const Salutation(this.displayTitle);
}

class LicenseRequestScreen extends StatelessWidget {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController snameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FRadioSelectGroupController<Salutation> radioController =
      FRadioSelectGroupController(value: Salutation.mr);

  LicenseRequestScreen({super.key});

  String statusDisplayBuilder(Salutation? status) {
    return Salutation.values.firstWhere((item) => item == status).displayTitle;
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Lizenz beantragen'),
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
                GenericSelectMenuTile<Salutation>(
                  controller: radioController,
                  label: 'Anrede',
                  items: Salutation.values,
                  displayBuilder: statusDisplayBuilder,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Status muss gewählt werden'
                      : null,
                  iconAsTitel: Icons.person,
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                        child: EmailAndText(
                      controller: fnameController,
                      label: 'Vorname',
                      isEmail: false,
                    )),
                    Expanded(
                        child: EmailAndText(
                      controller: snameController,
                      label: 'Vorname',
                      isEmail: false,
                    )),
                  ],
                ),
                Mobile(controller: mobileController, isMobile: true),
                EmailAndText(
                  controller: emailController,
                  label: 'Email',
                  isEmail: true,
                ),
                FButton(
                    onPress: () {
                      //TODO: anpassen
                      // AppRouter.navigateToRouteAfterDelay(context, AppRoutes.login);
                    },
                    label: false
                        ? const Text('Anfrage senden')
                        : false
                            ? SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : Icon(
                                Icons.check,
                                color: Colors.white,
                              ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
