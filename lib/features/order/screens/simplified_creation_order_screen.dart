import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class SimplifiedOrderCreationScreen extends StatefulWidget {
  const SimplifiedOrderCreationScreen({super.key});

  @override
  State<SimplifiedOrderCreationScreen> createState() =>
      _SimplifiedOrderCreationScreenState();
}

class _SimplifiedOrderCreationScreenState
    extends State<SimplifiedOrderCreationScreen>
    with SingleTickerProviderStateMixin {
  late FPopoverController controller;
  late FRadioSelectGroupController<String> groupController;

  // --- Controller für Aufnahme und Wiedergabe ---
  final RecorderController recorderController = RecorderController();
  late RecorderController stopedController = RecorderController();
  final PlayerController playerController = PlayerController(); // Hinzugefügt

  String? _applicationDocumentsPath;
  String? _recordingPath; // Pfad zur aktuellsten Aufnahme
  Duration? _finalDuration; // Finale Dauer nach dem Stoppen

  // --- Flags zur Statusverfolgung ---
  bool _isPlayerPrepared = false; // Zeigt an, ob der Player bereit ist

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
    groupController = FRadioSelectGroupController<String>();
    _loadApplicationDocumentsPath();

    // Listener für Player-Zustand (optional, aber gut für Debugging/Status)
    playerController.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          // Optional: UI an Player-Zustand anpassen (z.B. Play/Pause Icon ändern)
          _isPlayerPrepared = state == PlayerState.initialized ||
              state == PlayerState.paused ||
              state == PlayerState.playing;
        });
      }
      print("Player State Changed: $state");
    });
    // Listener für Recorder-Zustand (optional für Debugging)
    recorderController.onRecorderStateChanged.listen((state) {
      print("Recorder State Changed: $state");
      // Wenn gestoppt wird, setzen wir den Player-Zustand zurück
      if (state == RecorderState.stopped && mounted) {
        setState(() {
          _isPlayerPrepared = false; // Player muss neu vorbereitet werden
        });
      }
    });
  }

  Future<void> _loadApplicationDocumentsPath() async {
    // ... (unverändert) ...
    try {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      _applicationDocumentsPath = appDocumentsDir.path;
      print('App-Dokumentenpfad geladen: $_applicationDocumentsPath');
    } catch (e) {
      print('Fehler beim Abrufen des Anwendungsverzeichnisses: $e');
    }
  }

  // --- Aufnahme Starten ---
  Future<void> _startRecording() async {
    // Stelle sicher, dass der Player gestoppt ist, bevor eine neue Aufnahme beginnt
    if (playerController.playerState != PlayerState.stopped) {
      await playerController.stopPlayer();
    }
    // Setze vorherige Aufnahmeinfos zurück
    setState(() {
      _recordingPath = null;
      _finalDuration = null;
      _isPlayerPrepared = false;
    });

    if (_applicationDocumentsPath == null) {
      print("Fehler: Basispfad für Aufnahme nicht verfügbar.");
      await _loadApplicationDocumentsPath();
      if (_applicationDocumentsPath == null) return;
    }
    final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
    final path = '$_applicationDocumentsPath/$fileName';

    try {
      if (await recorderController.checkPermission()) {
        await recorderController.record(path: path); // Standard-Codec etc.
        setState(() {
          _recordingPath = path; // Pfad merken
        });
        print("Aufnahme gestartet, Pfad: $_recordingPath");
      } else {
        /* Berechtigung fehlt */
      }
    } catch (e) {
      /* Fehlerbehandlung */
    }
  }

  // --- Aufnahme Stoppen ---
  Future<void> _stopRecording() async {
    try {
      // Stoppe Recorder und erhalte den Pfad
      stopedController = recorderController;
      final path = await recorderController.stop();
      final duration =
          await playerController.getDuration(DurationType.max); // Dauer holen

      print("Aufnahme gestoppt, gespeichert unter: $path");
      print("Finale Dauer: $duration");

      if (path != null) {
        setState(() {
          _recordingPath = path;
          _finalDuration =
              Duration(milliseconds: duration); // Finale Dauer speichern
          _isPlayerPrepared = false; // Zuerst als nicht bereit markieren
        });

        // Bereite den Player VOR, um die Wellenform der gespeicherten Datei anzuzeigen
        // `shouldExtractWaveform: true` ist wichtig!
        await playerController.preparePlayer(
          path: path,
          shouldExtractWaveform: true,
          noOfSamples: 100, // Anzahl der Samples für die Welle anpassen
          volume: 1.0,
        );
        // Nach erfolgreichem preparePlayer wird der Player-State sich ändern
        // und der Listener oben setzt ggf. _isPlayerPrepared
        // Alternativ hier direkt setzen, wenn preparePlayer nicht fehlschlägt:
        if (mounted && playerController.playerState != PlayerState.stopped) {
          // Prüfen ob Vorbereitung geklappt hat
          setState(() {
            _isPlayerPrepared = true;
          });
        }
      } else {
        // Pfad war null nach dem Stoppen, Fehler?
        setState(() {
          _recordingPath = null;
          _finalDuration = null;
          _isPlayerPrepared = false;
        });
      }
    } catch (e) {
      print("Fehler beim Stoppen/Vorbereiten des Players: $e");
      setState(() {
        // Zustand zurücksetzen bei Fehler
        _recordingPath = null;
        _finalDuration = null;
        _isPlayerPrepared = false;
      });
    }
  }

  // --- Aufnahme Pausieren ---
  Future<void> _pauseRecording() async {
    try {
      await recorderController.pause();
      print("Aufnahme pausiert");
    } catch (e) {
      print("Fehler beim Pausieren: $e");
    }
    // setState wird implizit durch den StreamBuilder ausgelöst
  }

  // --- Aufnahme Fortsetzen ---
  Future<void> _resumeRecording() async {
    try {
      await recorderController.record();
      print("Aufnahme fortgesetzt");
    } catch (e) {
      print("Fehler beim Fortsetzen: $e");
    }
    // setState wird implizit durch den StreamBuilder ausgelöst
  }

  // --- Aufnahme Löschen/Abbrechen ---
  Future<void> _deleteRecording() async {
    try {
      // Stoppe Player und Recorder sicherheitshalber
      if (playerController.playerState != PlayerState.stopped)
        await playerController.stopPlayer();
      if (recorderController.recorderState != RecorderState.stopped)
        await recorderController.stop();

      print("Aufnahme/Player gestoppt/abgebrochen.");
      // Optional: Lösche die Datei
      if (_recordingPath != null) {
        final file = File(_recordingPath!);
        if (await file.exists()) {
          await file.delete();
          print("Datei gelöscht: $_recordingPath");
        }
      }
    } catch (e) {
      print("Fehler beim Stoppen/Löschen: $e");
    } finally {
      if (mounted) {
        setState(() {
          _recordingPath = null; // Pfad zurücksetzen
          _finalDuration = null;
          _isPlayerPrepared = false;
          // Der StreamBuilder wird die UI aktualisieren
        });
      }
    }
  }

  // --- Player Starten/Pausieren ---
  Future<void> _playPausePlayer() async {
    if (!_isPlayerPrepared || _recordingPath == null)
      return; // Nur wenn vorbereitet

    if (playerController.playerState == PlayerState.playing) {
      await playerController.pausePlayer();
    } else {
      // Startet von vorne oder setzt fort, je nach Zustand
      await playerController.startPlayer(); // Stoppt am Ende oder pausiert
    }
    // Der Player-State-Listener oben aktualisiert die UI (z.B. Play/Pause Icon)
  }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose(); // PlayerController auch disposen!
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        // ... dein bestehender Header ...
        title: const FittedBox(
          child: Text('Vereinfachte Auftragserstellung'),
        ),
        actions: [
          FPopoverMenu(
            popoverController: controller,
            menuAnchor: Alignment.topRight,
            childAnchor: Alignment.bottomRight,
            menu: [
              /* ... deine Menüeinträge ... */
            ],
            child: FHeaderAction(
              icon: FIcon(FAssets.icons.ellipsis),
              onPress: controller.toggle,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding für den Inhalt
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FTileGroup(
              label: const Text('Kunde'),
              children: [
                FTile(
                  // Dein Kunden-FTile bleibt hier
                  prefixIcon: FIcon(FAssets.icons.user),
                  title: const Text('Kunden auswählen...'),
                  suffixIcon: FIcon(FAssets.icons.chevronRight),
                  onPress: () {
                    /* ... dein showFSheet Code ... */
                  },
                ),
              ],
            ),

            StreamBuilder<RecorderState>(
              stream: recorderController.onRecorderStateChanged,
              builder: (context, recorderSnapshot) {
                final recorderState =
                    recorderSnapshot.data ?? RecorderState.stopped;

                // Bestimme, ob eine *abgeschlossene* Aufnahme angezeigt werden soll
                final showRecordedWaveform =
                    recorderState == RecorderState.stopped &&
                        _recordingPath != null &&
                        _isPlayerPrepared;

                // Bestimme, ob die *Live*-Aufnahme angezeigt werden soll
                final showRecordingWaveform =
                    recorderState == RecorderState.recording ||
                        recorderState == RecorderState.paused;

                return Column(
                  children: [
                    Text(
                      'Audio Notiz hinzufügen',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),

                    // --- Wellenform (Live oder Abgeschlossen) oder Platzhalter ---
                    if (showRecordingWaveform)
                      AudioWaveforms(
                        // LIVE-Welle
                        size:
                            Size(MediaQuery.of(context).size.width - 32, 100.0),
                        recorderController: recorderController,
                        waveStyle: const WaveStyle(
                          waveColor: Colors.blueAccent, // Live-Farbe
                          showDurationLabel: false,
                          scaleFactor: 150,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey.shade200,
                        ),
                      )
                    else if (showRecordedWaveform)
                      AudioWaveforms(
                        // ABGESCHLOSSENE Welle
                        size:
                            Size(MediaQuery.of(context).size.width - 32, 100.0),
                        recorderController: recorderController,
                        // PlayerController verwenden!
                        enableGesture: true,
                        // Gesten für Player erlauben
                        waveStyle: const WaveStyle(
                          waveColor: Colors.green,
                          // Farbe für gespeicherte Welle
                          showDurationLabel: true,
                          // Dauer anzeigen lassen
                          durationLinesColor: Colors.redAccent,
                          durationStyle: TextStyle(fontWeight: FontWeight.bold),
                          scaleFactor: 150,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey.shade200,
                        ),
                      )
                    else // Platzhalter
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey.shade200,
                        ),
                        child: const Center(
                            child: Icon(Icons.mic_none,
                                size: 40, color: Colors.grey)),
                      ),

                    const SizedBox(height: 10),

                    // --- Dauer-Anzeige ---
                    // Zeige entweder die laufende Dauer oder die finale Dauer an
                    Text(
                      _finalDuration != null
                          ? "Gesamt: ${_finalDuration!.toString().split('.').first.padLeft(8, '0')}" // Format H:MM:SS
                          : recorderState != RecorderState.stopped
                              ? "Aufnahme..." // Oder zeige hier die laufende Zeit vom Recorder, falls nötig
                              : "00:00", // Anfangszustand
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 16),

                    // --- Steuerungs-Buttons ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Löschen Button
                        // Sichtbar, wenn aufgenommen wird, pausiert ist ODER eine Aufnahme fertig ist
                        if (recorderState != RecorderState.stopped ||
                            _recordingPath != null)
                          IconButton(
                            icon: const Icon(Icons.delete_forever,
                                color: Colors.redAccent, size: 28),
                            onPressed: _deleteRecording,
                            tooltip: 'Aufnahme verwerfen',
                          )
                        else
                          const SizedBox(width: 48),
                        // Platzhalter

                        const SizedBox(width: 16),

                        // Haupt-Aktionsbutton (Record/Pause/Resume ODER Play/Pause für Player)
                        FloatingActionButton(
                          heroTag: 'audio_action_button',
                          onPressed: () async {
                            if (recorderState == RecorderState.recording) {
                              await _pauseRecording();
                            } else if (recorderState == RecorderState.paused) {
                              await _resumeRecording();
                            } else if (recorderState == RecorderState.stopped &&
                                _isPlayerPrepared) {
                              await _playPausePlayer(); // Starte/Pausiere Player
                            } else if (recorderState == RecorderState.stopped &&
                                _recordingPath == null) {
                              await _startRecording(); // Starte neue Aufnahme
                            }
                          },
                          // Unterschiedliche Farben/Icons je nach Zustand
                          backgroundColor:
                              recorderState == RecorderState.stopped &&
                                      !_isPlayerPrepared
                                  ? Colors.redAccent // Bereit für Aufnahme
                                  : Colors.blueAccent,
                          // Aufnahme läuft/pausiert ODER Player bereit
                          child: Icon(
                            (recorderState == RecorderState.stopped &&
                                    _isPlayerPrepared)
                                ? (playerController.playerState ==
                                        PlayerState.playing
                                    ? Icons.pause
                                    : Icons.play_arrow) // Player Play/Pause
                                : recorderState == RecorderState.recording
                                    ? Icons.pause
                                    : recorderState == RecorderState.paused
                                        ? Icons.play_arrow // Resume Recording
                                        : Icons.mic, // Start Recording
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Stopp Button (nur während Aufnahme/Pause)
                        if (recorderState == RecorderState.recording ||
                            recorderState == RecorderState.paused)
                          IconButton(
                            icon: const Icon(Icons.stop_circle_outlined,
                                color: Colors.black87, size: 28),
                            onPressed: _stopRecording,
                            tooltip: 'Aufnahme beenden & speichern',
                          )
                        else
                          const SizedBox(width: 48),
                        // Platzhalter
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24), // Abstand
          ],
        ),
      ),
    );
  }
}
