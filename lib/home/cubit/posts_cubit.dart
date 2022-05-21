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
    required int userId,
  }) async {
    emit(PostsCreateInProgress());
    try {
      final newPost = Post(
        title: postTitle,
        body: postBody,
        userId: userId,
      );

      final post = await postRepository.createPost(post: newPost);

      emit(PostsCreateSuccess(postId: post.id!));
    } on Object catch (e) {
      log(e.toString());
      emit(PostsCreateError());
    }
  }

  Future<void> editPost({
    required String postTitle,
    required String postBody,
    required int userId,
  }) async {
    emit(PostsEditInProgress());
    try {
      final newPost = Post(
        title: postTitle,
        body: postBody,
        userId: userId,
      );

      final post = await postRepository.createPost(post: newPost);

      emit(PostsEditSuccess(postId: post.id!));
    } on Object catch (e) {
      log(e.toString());
      emit(PostsEditError());
    }
  }
}
