import 'package:flutter/material.dart';
import 'package:test_http_api/models/post.dart';
import 'package:test_http_api/post/view/post_page.dart';
import 'package:test_http_api/posts/posts.dart';

class PostsBody extends StatefulWidget {
  const PostsBody({Key? key}) : super(key: key);

  @override
  State<PostsBody> createState() => _PostsBodyState();
}

class _PostsBodyState extends State<PostsBody> {
  ScrollController controller = ScrollController();
  bool loaderOpened = false;

  PostsNotifier get postsNotifier =>
      Provider.of<PostsNotifier>(context, listen: false);

  @override
  void initState() {
    super.initState();
    controller.addListener(() => _scrollListener());
    postsNotifier.init();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader(context);
    });
  }

  void _scrollListener() {
    if (postsNotifier.noMore) return;

    if (controller.position.extentAfter < 200) {
      postsNotifier.next();
      showLoader(context);
    }
  }

  void showLoader(context) async {
    if (loaderOpened) return;

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

  void hideLoader(context) async {
    if (loaderOpened) {
      Navigator.of(context).pop();
      loaderOpened = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsNotifier>(
      builder: (context, state, child) {
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
                  trailing: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    onPressed: (){
                      Navigator.pushNamed(
                        context,
                        '/post',
                        arguments: PostPageArguments(post.id)
                      );
                    },
                  ),
                  // onTap: () => openPost(context, post)
                ));
              },
            ));
      },
    );
  }
}
