#include "include/insta_login/insta_login_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "insta_login_plugin.h"

void InstaLoginPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  insta_login::InstaLoginPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
