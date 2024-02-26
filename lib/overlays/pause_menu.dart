import 'package:flutter/material.dart';
import 'package:recycle_rush/menus/main_menu.dart';
import 'package:recycle_rush/recycle_rush.dart';

import 'pause_button.dart';

// This class represents the pause menu overlay.
class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';
  final PixelAdventure game;

  const PauseMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Paused',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF211F30),
                shadows: [
                  Shadow(
                    blurRadius: 25.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),

          // Resume button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.resumeEngine();
                game.overlays.remove(PauseMenu.id);
                game.overlays.add(PauseButton.id);
              },
              child: const Text('Resume Game'),
            ),
          ),
          const SizedBox(height: 5),

          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(PauseMenu.id);
                game.overlays.add(PauseButton.id);
                game.restart();
                game.resumeEngine();
              },
              child: const Text('Restart Level'),
            ),
          ),
          const SizedBox(height: 5),
          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(PauseMenu.id);
                game.reset();
                game.resumeEngine();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
              child: const Text('Exit'),
            ),
          ),
        ],
      ),
    );
  }
}
