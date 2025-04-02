import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import 'button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: set buffer to 512 or 256 on Android to eliminate perceivable lag
  await SoLoud.instance.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final audioSources = <int, AudioSource>{};
  final audioDir = 'assets/audio';

  @override
  void dispose() {
    SoLoud.instance.deinit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var i = 1; i <= 3; i++)
                AudioButton(asset: '$audioDir/$i.mp3', label: 'Sound #$i'),
            ],
          ),
        ),
      ),
    );
  }
}
