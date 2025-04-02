import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class AudioButton extends StatelessWidget {
  const AudioButton({super.key, required this.asset, required this.label});

  final String asset, label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FutureBuilder(
        future: SoLoud.instance.loadAsset(asset),
        builder: (context, snapshot) {
          final child = Container(
            width: 160,
            height: 60,
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: Colors.blueGrey[700],
            ),
            child: Center(
              child:
                  snapshot.hasData ? Text(label) : CupertinoActivityIndicator(),
            ),
          );
          if (!snapshot.hasData) {
            return child;
          }
          final source = snapshot.data!;
          var pressed = false;
          SoundHandle? handle;
          return StatefulBuilder(
            builder: (context, setState) {
              return GestureDetector(
                onTapDown: (_) async {
                  handle = await SoLoud.instance.play(source);
                  setState(() => pressed = true);
                },
                onTapUp: (_) {
                  SoLoud.instance.stop(handle!);
                  setState(() => pressed = false);
                },
                onTapCancel: () {
                  SoLoud.instance.stop(handle!);
                  setState(() => pressed = false);
                },
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 100),
                  scale: pressed ? 0.95 : 1.0,
                  child: child,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
