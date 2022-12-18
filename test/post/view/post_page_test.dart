// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_http_api/post/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostPage', () {
    group('route', () {
      test('is routable', () {
        expect(PostPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders PostView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: PostPage()));
      expect(find.byType(PostView), findsOneWidget);
    });
  });
}
