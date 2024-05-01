import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_login/insta_login.dart';

import 'package:webview_flutter/webview_flutter.dart';

class InstaView extends StatefulWidget {
  const InstaView({
    super.key,
    required this.redirectUrl,
    required this.onComplete,
    required this.instaAppId,
    required this.instaAppSecret,
    this.javascriptChannel = 'InstaLogin',
  });
  final String redirectUrl, instaAppId, instaAppSecret, javascriptChannel;
  final Function(String, String, String) onComplete;

  @override
  State<InstaView> createState() => _InstaViewState();
}

class _InstaViewState extends State<InstaView> {
  late final WebViewController controller;
  final Instaservices services = Instaservices();

  @override
  void initState() {
    super.initState();
    if (kIsWeb == false) {
      final WebViewController control =
          WebViewController.fromPlatformCreationParams(
        const PlatformWebViewControllerCreationParams(),
      );

      control
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) async {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
            },
            onNavigationRequest: (NavigationRequest request) async {
              debugPrint('allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange change) async {
              debugPrint('url change to ${change.url}');
              final url = change.url ?? '';
              debugPrint('url: $url');
              if (url.contains(widget.redirectUrl)) {
                await onRedirectUrl(url);
              }
            },
          ),
        )
        ..addJavaScriptChannel(
          widget.javascriptChannel,
          onMessageReceived: (JavaScriptMessage message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message.message)),
            );
          },
        )
        ..runJavaScript(widget.javascriptChannel)
        ..loadRequest(
          Uri.parse(
            services.getUrl(
              appid: widget.instaAppId,
              redirectUrl: widget.redirectUrl,
            ),
          ),
        );
      controller = control;
    }
    setState(() {});
  }

  onRedirectUrl(String url) async {
    final code = services.getAuthorizationCode(
      url: url,
      redirectUrl: widget.redirectUrl,
    );
    setState(() {});
    await services
        .getTokenAndUserID(
      code: code,
      appid: widget.instaAppId,
      redirectUrl: widget.redirectUrl,
      appSecret: widget.instaAppSecret,
    )
        .then(
      (token) async {
        debugPrint('isDone: $token');
        if (token != {}) {
          await services
              .getUsername(
            accesstoken: token['access_token'].toString(),
            userid: token['user_id'].toString(),
          )
              .then(
            (username) {
              debugPrint('username: $username');
              setState(() {
                widget.onComplete(
                  token['access_token'].toString(),
                  token['user_id'].toString(),
                  username,
                );
              });
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb
          ? const Text('Under Construction')
          : WebViewWidget(controller: controller),
    );
  }
}
