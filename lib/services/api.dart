import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:test_http_api/models/post.dart';
// https://jsonplaceholder.typicode.com/guide/

class Api {
  final http.Client _client;

  Api({http.Client? client}) : _client = client ?? http.Client();

  Future<Iterable> fetchPosts({int page = 1, int limit = 20}) async {
    await Future.delayed(Duration(seconds: 1));

    Uri uri = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit'
    );

    log(uri.toString());

    final response = await _client.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPost(int postId) async {
    final response = await _client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
