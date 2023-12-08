import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'insta_login_method_channel.dart';

abstract class InstaLoginPlatform extends PlatformInterface {
  /// Constructs a InstaLoginPlatform.
  InstaLoginPlatform() : super(token: _token);

  static final Object _token = Object();

  static InstaLoginPlatform _instance = MethodChannelInstaLogin();

  /// The default instance of [InstaLoginPlatform] to use.
  ///
  /// Defaults to [MethodChannelInstaLogin].
  static InstaLoginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InstaLoginPlatform] when
  /// they register themselves.
  static set instance(InstaLoginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
