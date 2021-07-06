#include "include/preferences/preferences_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define PREFERENCES_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), preferences_plugin_get_type(), \
                              PreferencesPlugin))

struct _PreferencesPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(PreferencesPlugin, preferences_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void preferences_plugin_handle_method_call(
    PreferencesPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());

  fl_method_call_respond(method_call, response, nullptr);
}

static void preferences_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(preferences_plugin_parent_class)->dispose(object);
}

static void preferences_plugin_class_init(PreferencesPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = preferences_plugin_dispose;
}

static void preferences_plugin_init(PreferencesPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  PreferencesPlugin* plugin = PREFERENCES_PLUGIN(user_data);
  preferences_plugin_handle_method_call(plugin, method_call);
}

void preferences_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  PreferencesPlugin* plugin = PREFERENCES_PLUGIN(
      g_object_new(preferences_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "preferences",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
