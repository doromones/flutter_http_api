// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_http_api/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostsBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        Provider(
          create: (context) => ChangeNotifierProvider(create: (_) => PostsNotifier()),
          child: MaterialApp(home: PostsBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
