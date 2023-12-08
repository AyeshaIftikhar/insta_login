import 'package:insta_login/insta_login_platform_interface.dart';

class InstaLogin {
  Future<String?> getPlatformVersion() {
    return InstaLoginPlatform.instance.getPlatformVersion();
  }
}
