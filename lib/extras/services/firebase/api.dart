import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../authentication/controllers/auth_controller.dart';
import '../../../my_feeds/models/post.dart';

class FireApiClient {
  Future<List<Post>> getFeed() async {
    print("Starting getFeed...");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<Post> posts = [];

    if (AuthController.authInstance.firebaseUser.value != null) {
      String userId = AuthController.authInstance.firebaseUser.value!.uid;

      var url = 'https://us-central1-shamba-huru.cloudfunctions.net/getFeed';

      var httpClient = HttpClient();

      String result;

      try {
        print("Try-Catch Block...");

        Map json = {"uid": userId};

        Map<String, String> header = {"content-type": "application/json"};
        var response = await http.post(Uri.parse(url),
            body: jsonEncode(json), headers: header);
        var data = response.body;

        if (response.statusCode == HttpStatus.ok) {
          // String json = await response.transform(utf8.decoder).join();
          String json = data;

          if (json.isNotEmpty) {
            preferences.setString("feed", json);

            var data = jsonDecode(json);

            posts = generateFeed((data)[0]);

            result = "Success on http request for feeds";
          } else {
            result = "Json string is empty";
          }
        } else {
          // result = response.reasonPhrase;
          result =
              'Error getting a feed: Http status ${response.statusCode} | userId $userId';
        }
      } catch (exception) {
        result = 'Failed invoking the getFeed function. Exception: $exception';
      }

      print(result);

      return posts;
    }

    return posts.reversed.toList();
  }

  List<Post> generateFeed(List<dynamic> data) {
    List<Post> posts = [];

    print("generateFeed Method...");
    posts = (data).map((data) => Post.fromMap(data)).toList();
    print("POSTS LENGTH:: " + posts.length.toString());
    return posts.reversed.toList();
  }

  Future<List<Post>> loadFeed() async {
    print("loadFeed Method...");
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? json = preferences.getString("feed");

    print(json);
    if (json != null && json.isNotEmpty) {
      List<dynamic> data = jsonDecode(json);
      return generateFeed(data[0]);
    } else {
      return await getFeed();
    }
  }
}
