import 'dart:ffi';
import 'ffi.dart';
import 'package:ffi/ffi.dart';

// For C/Rust
typedef _hello_c = Pointer<Utf8> Function();

// For Dart
typedef _hello_dart = Pointer<Utf8> Function();

/// This class allows to call native code from Dart.
class Wallet {
  static DynamicLibrary _lib;

  Wallet() {
    if (_lib != null) return;
    _lib = load();
  }

  /// Retruns a String that says "Hello world" by calling the native "hello"
  /// method.
  String hello() {
    final helloPointer = _lib.lookup<NativeFunction<_hello_c>>('hello');
    final helloDart = helloPointer.asFunction<_hello_dart>();
    return helloDart().toDartString();
  }
}
