import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;

  BlogBloc(this._uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);
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
}
