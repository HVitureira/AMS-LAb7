import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repositories/repositories.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required this.postRepository}) : super(PostsInitial());
  final PostRepository postRepository;

  Future<void> loadPosts() async {
    emit(PostsLoadInProgress());
    try {
      final posts = await postRepository.getPosts();
      emit(PostsLoadSuccess(posts: posts));
    } on Object catch (e) {
      log(e.toString());
      emit(PostsLoadError());
    }
  }

  Future<void> createPost({
    required String postTitle,
    required String postBody,
  }) async {
    emit(PostsCreateInProgress());
    try {
      final newPost = Post(title: postTitle, body: postBody);

      await postRepository.createPost(post: newPost);

      emit(PostsCreateSuccess());
    } on Object catch (e) {
      log(e.toString());
      emit(PostsCreateError());
    }
  }
}
