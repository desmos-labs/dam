import Cocoa
import FlutterMacOS

public class PreferencesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "preferences", binaryMessenger: registrar.messenger)
    let instance = PreferencesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(FlutterMethodNotImplemented)
  }

  public func dummyMethodToEnforceBundling() {
    set_preferences_app_dir("");
    preferences_exist("");
    preferences_delete("");
    preferences("");
    encrypted_preferences("", "");
    preferences_free(nil);
    preferences_get_i32(nil, "", nil);
    preferences_put_i32(nil, "", 0);
    preferences_get_string(nil, "", nil, 0);
    preferences_put_string(nil, "", "");
    preferences_get_bool(nil, "", nil);
    preferences_put_bool(nil, "", false);
    preferences_get_bytes(nil, "", nil, 0);
    preferences_put_bytes(nil, "", nil, 0);
    preferences_clear(nil);
    preferences_erase(nil);
    preferences_save(nil);
    clear_last_error();
    last_error_length();
    error_message_utf8(nil, 0);
  }
}
