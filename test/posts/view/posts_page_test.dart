// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_http_api/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostsPage', () {
    group('route', () {
      test('is routable', () {
        expect(PostsPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders PostsView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: PostsPage()));
      expect(find.byType(PostsView), findsOneWidget);
    });
  });
}
