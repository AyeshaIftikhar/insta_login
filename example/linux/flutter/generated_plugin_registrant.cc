//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <insta_login/insta_login_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) insta_login_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "InstaLoginPlugin");
  insta_login_plugin_register_with_registrar(insta_login_registrar);
}
