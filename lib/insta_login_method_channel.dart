import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'insta_login_platform_interface.dart';

/// An implementation of [InstaLoginPlatform] that uses method channels.
class MethodChannelInstaLogin extends InstaLoginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('insta_login');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
