//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <preferences/preferences_plugin.h>
#include <window_size/window_size_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  PreferencesPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PreferencesPlugin"));
  WindowSizePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowSizePlugin"));
}
