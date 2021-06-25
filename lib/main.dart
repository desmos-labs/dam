import 'package:dam/di/di.dart';
import 'package:dam/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:window_size/window_size.dart';

void main() async {
  Preferences.setAppDir('dam');
  Di.setup();

  WidgetsFlutterBinding.ensureInitialized();
  if (DesmosPlatform.isDesktop) {
    setWindowTitle('Desmos Account Manager');
    setWindowMinSize(const Size(DesmosSizes.minWidth, DesmosSizes.minHeight));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MyApp());
}
