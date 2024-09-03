# Instagram Login/Connect

This package is intended to let developers easily integrate instagram integration in Flutter Application. We will be using `Instagram Basic Display API`. Currently it is supporting the following:

- Connect to Instagram
- Get Access Token for a particular user
- Get `userid`, `username`, `account_type`, `media_count` and `media`.

| [![Thumbnail](https://github.com/AyeshaIftikhar/insta_login/blob/main/demo/2.jpeg)](https://youtube.com/shorts/wElaG-Kq_20?feature=share)      |  
| --------------------------------------- | --------------------------------------- | 

[![Thumbnail](https://github.com/AyeshaIftikhar/insta_login/blob/main/demo/2.jpeg)](https://youtube.com/shorts/wElaG-Kq_20?feature=share)


## Upcoming Features

- Profile details in terms of (captions, email, etc)
- Download Reels
- Complete Working support on Web, MacOS, Linux, & Windows Platform

## Getting started

```dart
dart pub add insta_login
```

```dart
import 'package:insta_login/insta_login.dart';
```

## Usage

```dart
import 'package:insta_login/insta_login.dart';
InstaView(
    instaAppId: '215643524910532',
    instaAppSecret:'b19d87bf98b632e0319f2ebab495b345',
    redirectUrl: 'https://ayesha-iftikhar.web.app/',
    onComplete: (_token, _userid, _username) {
        WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
            setState(() {
                token = _token;
                userid = _userid;
                username = _username;
            });
        });
    },
),
```

## Setup

- Create an app on [Facebook Developer Platform](), by selecting `other` and App Type as `Comsumer or other`.
- Enable `Instagram Basic Display API`, and from the bottom create an application that will be your instagram app whose appid and secret we will be using in our api calls.
- Add Some instagram accounts to test the integration but after adding the account accept the invitation from `Setting > App and Websites` in your instagram account. You can follow this [link](ttps://www.instagram.com/accounts/manage_access/) as well.
- On Facebook Developer Platform, Add your required platforms in the settings.
- _**Note:** The Platform setup is same as, we are suppose to setup our application for facebook login and other services._


![setup](https://github.com/AyeshaIftikhar/insta_login/blob/main/setup/1.jpg)


## Example

```dart

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
```

## Screenshots

| ![screenshot 1](https://github.com/AyeshaIftikhar/insta_login/blob/main/demo/2.jpeg)       |  ![screenshot 2](https://github.com/AyeshaIftikhar/insta_login/blob/main/demo/flutter_01.png)       | ![screenshot 3](https://github.com/AyeshaIftikhar/insta_login/blob/main/demo/flutter_02.png)       |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| ![screenshot 4](https://github.com/AyeshaIftikhar/insta_login/blob/main/demo/flutter_03.png)       |       
