import 'package:flutter/material.dart';
import 'package:test_http_api/services/api.dart';

class PostsNotifier with ChangeNotifier {
  final List<Post> _posts = [];
  int _page = 1;
  bool _noMore = false;
  bool _alreadyLoad = false;

  int get page => _page;
  bool get noMore => _noMore;
  List<Post> get posts => _posts;

  void init() async {
    _posts.clear();
    _page = 1;
    _noMore = false;
    next();
  }

  void next() async {
    if (_alreadyLoad || _noMore) {
      return;
    }
    _alreadyLoad = true;
    Iterable posts = await Api().fetchPosts(page: _page);
    if (posts.length > 0) {
      for (var rawPost in posts) {
        _posts.add(
            Post.fromJson(rawPost)
        );
      }
      _page++;
    } else {
      _noMore = true;
    }
    _alreadyLoad = false;
    notifyListeners();
  }

  void clear() async {
    _posts.clear();
    notifyListeners();
  }
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body']);
  }
}

