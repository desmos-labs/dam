import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dam/preferences/preferences.dart';


void main() {
  // Initialize the app dir.
  Preferences.setAppDir('dam-tests');

  const TEST_STRING = 'a very long string just to stress the internal buffer '
      'used to receive the data from the native code.........................'
      '......................................................................'
      '......................................................................'
      '......................................................................';
  var TEST_BYTES = Uint8List(280);
  for (var i = 0; i < 280; i++) {
    TEST_BYTES[i] = (i % 255);
  }

  test('Test unencrypted preferences', () {
    const PREFERENCES_NAME = 'test-unencrypted';
    var preferences = Preferences.unencrypted(PREFERENCES_NAME);
    preferences.putInt('int', 42);
    preferences.putBool('bool', true);
    preferences.putString('string', TEST_STRING);
    preferences.putBytes('bytes', TEST_BYTES);
    
    preferences.save();
    preferences.destroy();

    // Reload the data from disk
    preferences = Preferences.unencrypted(PREFERENCES_NAME);
    expect(preferences.getInt('int'), 42);
    expect(preferences.getBool('bool'), true);
    expect(preferences.getString('string'), TEST_STRING);
    expect(preferences.getBytes('bytes'), TEST_BYTES);

    preferences.erase();
    preferences.destroy();
  });

  test('Test encrypted preferences', () {
    const PREFERENCES_NAME = 'test-encrypted';
    var preferences = Preferences.encrypted(PREFERENCES_NAME, 'secret-key');
    preferences.putInt('int', 42);
    preferences.putBool('bool', true);
    preferences.putString('string', TEST_STRING);
    preferences.putBytes('bytes', TEST_BYTES);

    preferences.save();
    preferences.destroy();

    // Reload the data from disk
    preferences = Preferences.encrypted(PREFERENCES_NAME, 'secret-key');
    expect(preferences.getInt('int'), 42);
    expect(preferences.getBool('bool'), true);
    expect(preferences.getString('string'), TEST_STRING);
    expect(preferences.getBytes('bytes'), TEST_BYTES);

    preferences.erase();
    preferences.destroy();
  });

  test('Test encrypted preferences wrong password', () {
    const PREFERENCES_NAME = 'test-wrong-pass';
    var preferences = Preferences.encrypted(PREFERENCES_NAME, 'secret-key');
    preferences.save();
    preferences.destroy();

    // Try reload with a wrong password.
    expect(() {
      Preferences.encrypted(PREFERENCES_NAME, 'wrong_key');
    }, throwsA(isInstanceOf<InvalidPreferencesPassword>()));

    // Clear the disk
    preferences =  Preferences.encrypted(PREFERENCES_NAME, 'secret-key');
    preferences.erase();
    preferences.destroy();
  });
}
