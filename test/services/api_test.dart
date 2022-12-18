import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:test_http_api/models/post.dart';
import 'package:test_http_api/services/api.dart';

import 'api_test.mocks.dart';

// flutter pub run build_runner build
@GenerateMocks([http.Client])
void main() {
  group('fetchPosts', () {
    test('returns Posts array without mocks', skip: false, () async {
      Iterable posts = await Api().fetchPosts();
      Post post = Post.fromJson(posts.first);
      expect(post, isA<Post>());
    });

    test('returns which mocks', () async {
      http.Client client = MockClient();
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=1&_limit=20')))
          .thenAnswer((_) async => http.Response(
              json.encode([
                {"userId": 1, "id": 2, "title": "mock", "body": "mock"},
                {"userId": 1, "id": 23, "title": "mock", "body": "mock"}
              ]),
              200));

      Iterable posts = await Api(client: client).fetchPosts();
      Post post = Post.fromJson(posts.first);
      expect(post, isA<Post>());
    });
  });

  group('fetchPost', () {
    test('returns Post array without mocks', skip: false, () async {
      final Post post = Post.fromJson(await Api().fetchPost(1));
      expect(post, isA<Post>());
    });

    test('returns which mocks', () async {
      http.Client client = MockClient();
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')))
          .thenAnswer((_) async => http.Response(
              json.encode(
                  {"userId": 1, "id": 2, "title": "mock", "body": "mock"}),
              200));

      final Post post = Post.fromJson(await Api(client: client).fetchPost(1));
      expect(post, isA<Post>());
    });
  });
}
