FILES=-name '*.dart' ! -name '*.g.dart' ! -path './dart_tool' ! -path '*/generated/*' ! -path '*/proto/*'

lint:
	find . $(FILES) | tr '\n' ' ' | xargs flutter format --dry-run --set-exit-if-changed
	flutter analyze

format:
	find . $(FILES) | tr '\n' ' ' | xargs flutter format

generate-lib:
	cargo make
	mv -f target/aarch64-linux-android/debug/libwallet_ffi.so packages/wallet/android/src/main/jniLibs/arm64-v8a/
	mv -f target/armv7-linux-androideabi/debug/libwallet_ffi.so packages/wallet/android/src/main/jniLibs/armeabi-v7a/
	mv -f target/i686-linux-android/debug/libwallet_ffi.so packages/wallet/android/src/main/jniLibs/x86/

