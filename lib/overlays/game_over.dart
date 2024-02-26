import 'package:flutter/material.dart';
import 'package:recycle_rush/menus/main_menu.dart';
import 'package:recycle_rush/recycle_rush.dart';

import 'pause_button.dart';

// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final PixelAdventure game;

  const GameOverMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Game Over',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color:  Color(0xFF211F30),
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),

          // Informative text.
          // Informative text with color and shadow.
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Thanks for saving the planet!\nMore levels coming soon...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF211F30), // Added color
                shadows: [
                  Shadow(
                    blurRadius: 10.0, // Adjust blur radius as needed
                    color: Colors.white.withOpacity(0.5), // Shadow color with transparency
                    offset: const Offset(2.0, 2.0), // Shadow offset
                  ),
                ],
              ),
            ),
          ),

          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
                game.overlays.add(PauseButton.id);
                game.reset();
                game.resumeEngine();
              },
              child: const Text('Restart'),
            ),
          ),

          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
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