// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:insta_login/insta_login.dart';
import 'package:insta_login/insta_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String token = '', userid = '', username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (token != '' || userid != '' || username != '')
                Text(
                  'Access Token: $token\n\nUser Id: $userid\n\nUsername: $username',
                )
              else
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return InstaView(
                              instaAppId: '215643524910532',
                              instaAppSecret:
                                  'b19d87bf98b632e0319f2ebab495b345',
                              redirectUrl: 'https://ayesha-iftikhar.web.app/',
                              onComplete: (_token, _userid, _username) {
                                WidgetsBinding.instance.addPostFrameCallback(
                                  (timeStamp) {
                                    setState(() {
                                      token = _token;
                                      userid = _userid;
                                      username = _username;
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Connect to Instagram'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
