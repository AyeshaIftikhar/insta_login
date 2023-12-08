import 'package:flutter_test/flutter_test.dart';
import 'package:insta_login/insta_login_platform_interface.dart';
import 'package:insta_login/insta_login_method_channel.dart';
import 'package:insta_login/src/insta_login.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInstaLoginPlatform
    with MockPlatformInterfaceMixin
    implements InstaLoginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InstaLoginPlatform initialPlatform = InstaLoginPlatform.instance;

  test('$MethodChannelInstaLogin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInstaLogin>());
  });

  test('getPlatformVersion', () async {
    InstaLogin instaLoginPlugin = InstaLogin();
    MockInstaLoginPlatform fakePlatform = MockInstaLoginPlatform();
    InstaLoginPlatform.instance = fakePlatform;

    expect(await instaLoginPlugin.getPlatformVersion(), '42');
  });
}
