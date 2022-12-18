import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
// https://jsonplaceholder.typicode.com/guide/

class Api {
  final http.Client _client;
  final String _domain = 'https://jsonplaceholder.typicode.com';

  Api({http.Client? client}) : _client = client ?? http.Client();

  Future<Iterable> fetchPosts({int page = 1, int limit = 20}) async {
    Uri uri = Uri.parse('$_domain/posts?_page=$page&_limit=$limit');
    final response = await get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Map<String, dynamic>> fetchPost(int postId) async {
    Uri uri = Uri.parse('$_domain/posts/$postId');
    final response = await get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw NotFoundException('Failed to load post');
    }
  }

  Future<http.Response> get(Uri uri) async {
    // await Future.delayed(const Duration(seconds: 1));
    log(uri.toString());

    return _client.get(uri);
  }
}

class NotFoundException implements Exception {
  String cause;

  NotFoundException(this.cause);
}
