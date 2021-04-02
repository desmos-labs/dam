//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <wallet/wallet_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) wallet_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WalletPlugin");
  wallet_plugin_register_with_registrar(wallet_registrar);
}
