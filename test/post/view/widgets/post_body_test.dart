// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_http_api/post/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        Provider(
          create: (context) => ChangeNotifierProvider(create: (_) => PostNotifier()),
          child: MaterialApp(home: PostBody(pageArguments: PostPageArguments(2),)),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
