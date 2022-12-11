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
  setUp(() async {
    client = http.Client();
  });

  group('fetchPosts', () {
    test('returns Posts array without mocks', skip: false, () async {
      final Future<List<Post>> posts = fetchPosts();
      expect(await posts, isA<List<Post>>());
    });

    test('returns which mocks', () async {
      client = MockClient();
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer((_) async => http.Response(
              json.encode([
                {"userId": 1, "id": 2, "title": "mock", "body": "mock"},
                {"userId": 1, "id": 23, "title": "mock", "body": "mock"}
              ]),
              200));
      expect(await fetchPosts(), isA<List<Post>>());
    });
  });

  group('fetchPost', () {
    test('returns Post array without mocks', skip: false, () async {
      final Future<Post> post = fetchPost(1);
      expect(await post, isA<Post>());
    });

    test('returns which mocks', () async {
      client = MockClient();
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')))
          .thenAnswer((_) async => http.Response(
              json.encode(
                  {"userId": 1, "id": 2, "title": "mock", "body": "mock"}),
              200));

      expect(await fetchPost(1), isA<Post>());
    });
  });
}
