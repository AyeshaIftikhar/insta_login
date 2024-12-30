// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:insta_login/insta_login.dart';
import 'package:insta_login/insta_view.dart';
import 'package:insta_login_example/extensions/numeric.dart';
import 'package:insta_login_example/widgets/text_widgets.dart';

import 'detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
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
  String token = '', userid = '', username = '', accountType = '';
  int mediaCount = -1;
  List<dynamic> mediaList = [];

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          '------Instagram Connected------',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      5.vertical,
                      InfoWidget(title: 'Access Token', subtitle: token),
                      InfoWidget(title: 'Userid', subtitle: userid),
                      InfoWidget(title: 'Username', subtitle: username),
                      const SizedBox(height: 10),
                      if (accountType != '' || mediaCount != -1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                '------Basic Profile Details------',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            5.vertical,
                            InfoWidget(
                              title: 'Media Count',
                              subtitle: mediaCount.toString(),
                            ),
                            InfoWidget(
                              title: 'Account Type',
                              subtitle: accountType,
                            ),
                          ],
                        )
                      else
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await Instaservices()
                                  .getContent(
                                      accesstoken: token, userid: userid)
                                  .then((value) {
                                if (value != null) {
                                  accountType = value['account_type'];
                                  mediaCount = value['media_count'];
                                }
                                setState(() {});
                              });
                            },
                            child: const Text('Get Basic Profile Details'),
                          ),
                        ),
                      const SizedBox(height: 10),
                      if (mediaList.isNotEmpty)
                        Expanded(
                          child: Column(
                            children: [
                              const Center(
                                child: Text(
                                  '------Media List------',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              5.vertical,
                              Expanded(
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  children: List.generate(
                                    mediaList.length,
                                    (index) {
                                      var media = mediaList[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                url: media['media_url'],
                                                media: media,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  media['media_url']),
                                            ),
                                          ),
                                          child: media['media_type'] == 'VIDEO'
                                              ? const Icon(Icons.videocam)
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await Instaservices()
                                  .fetchUserMedia(
                                userId: userid,
                                accessToken: token,
                              )
                                  .then((value) {
                                mediaList = value;
                                setState(() {});
                              });
                            },
                            child: const Text('Get Media'),
                          ),
                        )
                    ],
                  ),
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
                              instaAppId: dotenv.get('appid'),
                              instaAppSecret: dotenv.get('app_secret'),
                              redirectUrl: dotenv.get('redirect_url'),
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
