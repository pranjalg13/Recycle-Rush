import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:recycle_rush/overlays/game_over.dart';
import 'package:recycle_rush/overlays/pause_button.dart';
import 'package:recycle_rush/overlays/pause_menu.dart';
import 'package:recycle_rush/recycle_rush.dart';

// Creating this as a file private object so as to
// avoid unwanted rebuilds of the whole game object.
PixelAdventure _rushAdventureGame = PixelAdventure();

// This class represents the actual game screen
// where all the action happens.
class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WillPopScope provides us a way to decide if
      // this widget should be poped or not when user
      // presses the back button.
      body: PopScope(
        canPop: false,
        // GameWidget is useful to inject the underlying
        // widget of any class extending from Flame's Game class.
        child: GameWidget(
          game: _rushAdventureGame,
          // Initially only pause button overlay will be visible.
          initialActiveOverlays: const [PauseButton.id],
          overlayBuilderMap: {
            PauseButton.id: (BuildContext context, PixelAdventure game) =>
                PauseButton(
                  game: game,
                ),
            PauseMenu.id: (BuildContext context, PixelAdventure game) =>
                PauseMenu(
                  game: game,
                ),
            GameOverMenu.id: (BuildContext context, PixelAdventure game) =>
                GameOverMenu(
                  game: game,
                ),
          },
        ),
      ),
    );
  }
}
