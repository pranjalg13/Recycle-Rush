import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:recycle_rush/recycle_rush.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final margin = 40;
  final baseButtonSize = 64.0; // Original button size
  final buttonScale = 1.5; // Adjust this value to control the size increase


  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    size = Vector2(baseButtonSize, baseButtonSize) * buttonScale; // Scale the button

    position = Vector2(
      game.size.x - margin - baseButtonSize,
      game.size.y - margin - baseButtonSize,
    );
    priority = 10;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
