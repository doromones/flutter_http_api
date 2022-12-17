import 'package:flutter/material.dart';
import 'package:test_http_api/posts/provider/provider.dart';
import 'package:test_http_api/posts/widgets/posts_body.dart';

/// {@template posts_page}
/// A description for PostsPage
/// {@endtemplate}
class PostsPage extends StatelessWidget {
  /// {@macro posts_page}
  const PostsPage({super.key});

  /// The static route for PostsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PostsPage());
  }
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostsNotifier(),
      child: const Scaffold(
        body: PostsView(),
      ),
    );
  }   
}

/// {@template posts_view}
/// Displays the Body of PostsView
/// {@endtemplate}
class PostsView extends StatelessWidget {
  /// {@macro posts_view}
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PostsBody();
  }
}
