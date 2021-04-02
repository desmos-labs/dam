generate-lib:
	cargo make
	mv -f target/aarch64-linux-android/debug/libwallet_ffi.so packages/wallet/android/src/main/jniLibs/arm64-v8a/
	mv -f target/armv7-linux-androideabi/debug/libwallet_ffi.so packages/wallet/android/src/main/jniLibs/armeabi-v7a/
	mv -f target/i686-linux-android/debug/libwallet_ffi.so packages/wallet/android/src/main/jniLibs/x86/

