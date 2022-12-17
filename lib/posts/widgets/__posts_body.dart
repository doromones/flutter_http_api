import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_http_api/posts/provider/provider.dart';

/// {@template posts_body}
/// Body of the PostsPage.
///
/// Add what it does
/// {@endtemplate}
class PostsBody extends StatelessWidget {
  /// {@macro posts_body}
  PostsBody({super.key});
  bool loaderOpened = false;

  Future initState(BuildContext context) async {
    showLoader(context);
    Provider.of<PostsNotifier>(context, listen: false).init();
  }

  void showLoader(context) {
    if (!loaderOpened) {
      loaderOpened = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          });
    }
  }

  void hideLoader(context) {
    if (loaderOpened) {
      Navigator.of(context).pop();
      loaderOpened = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    initState(context);

    ScrollController controller = ScrollController();

    void _scrollListener(context, state) {
      if (state.noMore) {
        return;
      }
      print(controller.position.extentAfter);

      if (controller.position.extentAfter < 200) {
        showLoader(context);
        Provider.of<PostsNotifier>(context, listen: false).next();
      }
    }

    void openPost(BuildContext context, Post post) {
      print('werwer');
    }

    return Consumer<PostsNotifier>(
      builder: (context, state, child) {
        controller.addListener(() => _scrollListener(context, state));
        hideLoader(context);

        return Scrollbar(
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                Post post = state.posts[index];
                return Card(
                    child: ListTile(
                        title: Text("${post.id} - ${post.title}"),
                        onTap: () => openPost(context, post)));
              },
            ));
      },
    );
  }
}
