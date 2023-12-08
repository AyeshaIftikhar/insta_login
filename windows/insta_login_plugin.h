#ifndef FLUTTER_PLUGIN_INSTA_LOGIN_PLUGIN_H_
#define FLUTTER_PLUGIN_INSTA_LOGIN_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace insta_login {

class InstaLoginPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  InstaLoginPlugin();

  virtual ~InstaLoginPlugin();

  // Disallow copy and assign.
  InstaLoginPlugin(const InstaLoginPlugin&) = delete;
  InstaLoginPlugin& operator=(const InstaLoginPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace insta_login

#endif  // FLUTTER_PLUGIN_INSTA_LOGIN_PLUGIN_H_
