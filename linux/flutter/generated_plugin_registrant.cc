//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <preferences/preferences_plugin.h>
#include <window_size/window_size_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) preferences_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PreferencesPlugin");
  preferences_plugin_register_with_registrar(preferences_registrar);
  g_autoptr(FlPluginRegistrar) window_size_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WindowSizePlugin");
  window_size_plugin_register_with_registrar(window_size_registrar);
}
