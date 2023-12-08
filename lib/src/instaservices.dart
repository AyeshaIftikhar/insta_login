import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Instaservices {
  List<String> usernameFields = ['id', 'username'];

  String getUrl({
    required String appid,
    required String redirectUrl,
    String responseType = 'code',
  }) {
    return 'https://api.instagram.com/oauth/authorize?client_id=$appid&redirect_uri=$redirectUrl&scope=user_profile,user_media&response_type=$responseType';
  }

  String getAuthorizationCode({
    required String url,
    required String redirectUrl,
  }) {
    String authorizationCode =
        url.replaceAll('$redirectUrl?code=', '').replaceAll('#_', '');
    debugPrint('authorization code: $authorizationCode');
    return authorizationCode;
  }

  Future<Map<String, dynamic>> getTokenAndUserID({
    required String appid,
    required String redirectUrl,
    required String code,
    required String appSecret,
  }) async {
    try {
      var url = Uri.parse('https://api.instagram.com/oauth/access_token');
      final body = {
        'client_id': appid,
        'redirect_uri': redirectUrl,
        'client_secret': appSecret,
        'code': code,
        'grant_type': 'authorization_code'
      };
      final response = await http.post(url, body: body);
      debugPrint('response: ${response.body}');
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  Future<String> getUsername({
    required String accesstoken,
    required String userid,
    List<String>? fields,
  }) async {
    try {
      String scopes = '';
      if (fields != null) {
        scopes = fields.join(',');
      } else {
        scopes = usernameFields.join(',');
      }
      final response = await http.get(
        Uri.parse(
          'https://graph.instagram.com/$userid?fields=$scopes&access_token=$accesstoken',
        ),
      );
      final body = jsonDecode(response.body);
      debugPrint('body: $body');
      return body['username'];
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}
