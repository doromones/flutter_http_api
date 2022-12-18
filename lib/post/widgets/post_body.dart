import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_http_api/post/post.dart';
import 'package:test_http_api/post/provider/post_provider.dart';
import 'package:test_http_api/models/post.dart';

class PostBody extends StatefulWidget {
  final PostPageArguments pageArguments;
  const PostBody({Key? key, required this.pageArguments}) : super(key: key);

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  PostNotifier get postNotifier =>
      Provider.of<PostNotifier>(context, listen: false);

  @override
  void initState() {
    super.initState();

    postNotifier.loadPost(widget.pageArguments.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostNotifier>(
      builder: (context, state, child) {
        Widget postWidget =
            state.postExists
                ? _PostWidget(post: state.post)
                : const _PostNotFound();
        return postWidget;
      },
    );
  }
}

class _PostWidget extends StatelessWidget {
  Post? post;

  _PostWidget({
    Key? key,
    this.post
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      constraints: BoxConstraints.expand(),
      color: Colors.teal,
      child: Column(
        // textDirection: TextDirection.ltr,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Post: id = ${post!.id}"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Post: userId = ${post!.userId}"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Post: title = ${post!.title}"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Post: body = ${post!.body}"),
          ),
        ],
      ),
    );
  }
}

class _PostNotFound extends StatelessWidget {
  const _PostNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Post not found");
  }
}
