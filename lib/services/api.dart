import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_http_api/models/post.dart';
// https://jsonplaceholder.typicode.com/guide/

http.Client client = http.Client();

Future<List<Post>> fetchPosts() async {
  final response =
      await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    Iterable array = jsonDecode(response.body);
    List<Post> posts =
        List<Post>.from(array.map((model) => Post.fromJson(model)));

    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<Post> fetchPost(int postId) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));
  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
