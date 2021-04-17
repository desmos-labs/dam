import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:window_size/window_size.dart';
import 'package:worker_manager/worker_manager.dart';

void main() async {
  await Executor().warmUp();
  WidgetsFlutterBinding.ensureInitialized();
  if (DesmosPlatform.isDesktop) {
    setWindowTitle('Desmos Account Manager');
    setWindowMinSize(const Size(DesmosSizes.minWidth, DesmosSizes.minHeight));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MyApp());
}
