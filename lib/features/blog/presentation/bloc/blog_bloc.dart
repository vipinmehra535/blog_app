import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _getAllBlogs = getAllBlogs,
        _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);

    on<BlogFetchAllBlogs>(_blogFetchAllBlogs);
  }

  FutureOr<void> _blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    try {
      final result = await _uploadBlog(UploadedBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ));

      result.fold(
        (l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogUploadSuccess()),
      );
    } on Failure catch (e) {
      emit(BlogFailure(e.message));
    }
  }

  FutureOr<void> _blogFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());

    res.fold((l) => (l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogDisplaySuccess(r)));
  }
}
