import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static Route route(Blog blog) {
    return MaterialPageRoute(builder: (_) => BlogViewerPage(blog: blog));
  }

  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog ApP'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            blog.title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
