import 'dart:io';

import 'package:dam/di/di.dart';
import 'package:dam/preferences/preferences.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Di.setup();

  if (Platform.isWindows | Platform.isLinux | Platform.isMacOS) {
    Preferences.setAppDir('dam');
  } else if (Platform.isAndroid) {
    var appDocDir = await getApplicationDocumentsDirectory();
    Preferences.setAppDir(appDocDir.path);
  }

  if (DesmosPlatform.isDesktop) {
    setWindowTitle('Desmos Account Manager');
    setWindowMinSize(const Size(DesmosSizes.minWidth, DesmosSizes.minHeight));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MyApp());
}
