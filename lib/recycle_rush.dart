import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:recycle_rush/components/jump_button.dart';
import 'package:recycle_rush/components/player.dart';
import 'package:recycle_rush/components/level.dart';
import 'package:recycle_rush/overlays/game_over.dart';
import 'package:recycle_rush/overlays/pause_button.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  Player player = Player(character: 'Virtual Guy');
  late JoystickComponent joystick;
  bool showControls = kIsWeb ? false: true;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = ['Level-01', 'Level-02', 'Level-03'];
  int currentLevelIndex = 0;

  int totalFruits = 0;
  int collectedFruits = 0;
  // Indicates weather the game world has been already initialized.
  bool _isAlreadyLoaded = false;

  @override
  FutureOr<void> onLoad() async {
    if (!_isAlreadyLoaded) {
      // Load all images into cache
      await images.loadAllImages();

      _loadLevel();

      if (showControls) {
        addJoystick();
        add(JumpButton());
      }

      return super.onLoad();
    }
    _isAlreadyLoaded = true;
  }

  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    const double joystickScale = 1.5; // Adjust this value to your desired size

    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 10, bottom: 10),
    );
    joystick.scale = Vector2(joystickScale, joystickScale);

    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    removeWhere((component) => component is Level);

    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      collectedFruits = 0;
      _loadLevel();
    } else {
      pauseEngine();
      overlays.remove(PauseButton.id);
      overlays.add(GameOverMenu.id);
      // no more levels
      // collectedFruits = 0;
      // currentLevelIndex = 0;
      // _loadLevel();
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration(milliseconds: 250), () {
      Level world = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );

      cam = CameraComponent.withFixedResolution(
        world: world,
        width: 640,
        height: 360,
      );
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);
    });
  }

  void reset() {
    collectedFruits = 0;
    currentLevelIndex = -1;
    loadNextLevel();
  }

  void restart() {
    collectedFruits = 0;
    currentLevelIndex = currentLevelIndex - 1;
    loadNextLevel();
  }

  void incrementCollectedFruits() {
    collectedFruits++;
  }

  bool hasCollectedAllFruits() {
    return collectedFruits == totalFruits;
  }
}
