import 'package:flutter/material.dart';
import 'package:insta_login_example/widgets/text_widgets.dart';

class DetailScreen extends StatelessWidget {
  final String url;
  final dynamic media;
  const DetailScreen({required this.url, super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media Detail')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoWidget(title: 'Media id', subtitle: media['id']),
            InfoWidget(title: 'Media Type', subtitle: media['media_type']),
            InfoWidget(title: 'Timestamp', subtitle: media['timestamp']),
            InfoWidget(title: 'Media Url', subtitle: media['media_url']),
          ],
        ),
      ),
    );
  }
}
