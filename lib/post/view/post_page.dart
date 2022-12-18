import 'package:flutter/material.dart';
import 'package:test_http_api/post/post.dart';
import 'package:test_http_api/post/provider/provider.dart';
import 'package:test_http_api/post/widgets/post_body.dart';

/// {@template post_page}
/// A description for PostPage
/// {@endtemplate}
class PostPage extends StatelessWidget {
  /// {@macro post_page}
  const PostPage({super.key});

  /// The static route for PostPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PostPage());
  }
 
  @override
  Widget build(BuildContext context) {
    final pageArguments = ModalRoute.of(context)!.settings.arguments as PostPageArguments;
    print(pageArguments.postId.toString());

    return ChangeNotifierProvider(
      create: (context) => PostNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sample Code'),
        ),
        body: PostView(pageArguments: pageArguments,),
      ),
    );
  }   
}

/// {@template post_view}
/// Displays the Body of PostView
/// {@endtemplate}
class PostView extends StatelessWidget {
  final PostPageArguments pageArguments;
  /// {@macro post_view}
  const PostView({super.key, required this.pageArguments});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PostBody(pageArguments: pageArguments,)
    );
  }
}

class PostPageArguments {
  final int postId;

  PostPageArguments(this.postId);
}