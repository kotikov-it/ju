import 'package:forui/forui.dart';
import 'package:flutter/material.dart';

class GenericSelectMenuTile<T extends Object> extends StatefulWidget {
  /// Die Liste der verfügbaren Optionen vom Typ T.
  final List<T> items;

  /// Eine Funktion, die ein Element vom Typ T (oder null) in einen
  /// darzustellenden String umwandelt.
  final String Function(T? item) displayBuilder;

  final IconData iconAsTitel;

  /// Optionales Icon vor dem Titel.
  final Widget? prefixIcon;

  /// Optional: Validator-Funktion.
  final FormFieldValidator<Iterable<T>>? validator;

  /// Optional: Ob das Menü automatisch geschlossen werden soll.
  final bool autoHide;
  final String label;

  late FRadioSelectGroupController<T> controller;

  // Konstruktor mit erforderlichen Parametern für die generische Nutzung
  GenericSelectMenuTile({
    super.key,
    required this.items,
    required this.displayBuilder,
    this.prefixIcon, // Ursprüngliches Icon kann optional übergeben werden
    this.validator,
    this.autoHide = true,
    required this.label,
    required this.iconAsTitel,
    required this.controller, // Standardwert aus Original beibehalten
  });

  @override
  // State-Klasse ebenfalls generisch machen
  State<GenericSelectMenuTile<T>> createState() =>
      _GenericSelectMenuTileState<T>();
}

// 2. State-Klasse generisch machen
class _GenericSelectMenuTileState<T extends Object>
    extends State<GenericSelectMenuTile<T>> {
  @override
  Widget build(BuildContext context) {
    // Das FSelectMenuTile mit den generischen Parametern aus dem Widget verwenden
    return FSelectMenuTile<T>(
      label: Text(widget.label),
      // Explizit <T> hinzufügen
      groupController: widget.controller,
      autoHide: widget.autoHide,
      // Aus Widget-Parameter
      validator: widget.validator ?? // Aus Widget-Parameter oder Standard
          (value) => (value == null || value.isEmpty) ? 'Select an item' : null,
      prefixIcon: widget.prefixIcon,
      // Aus Widget-Parameter
      title: Icon(
        widget.iconAsTitel,
        size: 20,
      ),
      // Aus Widget-Parameter

      // Die Detailanzeige verwendet den displayBuilder
      details: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) =>
            Text(widget.displayBuilder(widget.controller.value.firstOrNull)),
      ),
      // Das Menü wird dynamisch aus den übergebenen items erstellt
      menu: widget.items.map((item) {
        // Für jede Option ein FSelectTile erstellen
        return FSelectTile<T>(
          // Explizit <T> hinzufügen
          // Verwende den displayBuilder für den Titel der Option
          title: Text(widget.displayBuilder(item)),
          value: item, // Der tatsächliche Wert vom Typ T
        );
      }).toList(), // Konvertiere das Iterable in eine Liste
    );
  }

  @override
  void dispose() {
    // Den intern erstellten Controller freigeben
    widget.controller.dispose();
    super.dispose();
  }
}
