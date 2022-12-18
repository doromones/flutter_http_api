import 'package:flutter/material.dart';
import 'package:test_http_api/models/post.dart';
import 'package:test_http_api/services/api.dart';

class PostNotifier with ChangeNotifier {
  Post? _post;
  bool _postExists = false;

  bool get postExists => _postExists;
  Post? get post => _post;

  void loadPost(postId) async {
    try {
      _post = Post.fromJson(await Api().fetchPost(postId));
      _postExists = true;
    } on NotFoundException {
      _postExists = false;
    }

    notifyListeners();
  }
}
