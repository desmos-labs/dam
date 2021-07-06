import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

extension Uint8ListPointer on Uint8List {
  // https://github.com/dart-lang/ffi/issues/31
  // Workaround: before does not allow direct pointer exposure
  Pointer<Uint8> getPointer({Allocator allocator = malloc}) {
    final ptr = allocator.allocate<Uint8>(length);
    final byteList = ptr.asTypedList(length);
    byteList.setAll(0, this);
    return ptr.cast();
  }
}
