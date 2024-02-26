import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:recycle_rush/menus/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  // PixelAdventure game = PixelAdventure();
  runApp(MaterialApp(
    themeMode: ThemeMode.dark,
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark(),
    home: const MainMenu(),
  ));
}
