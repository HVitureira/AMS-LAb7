import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repositories/repositories.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required this.postRepository})
      : super(const PostsInitial(posts: []));
  final PostRepository postRepository;

  Future<void> loadPosts() async {
    emit(PostsLoadInProgress(posts: state.posts));
    try {
      final posts = await postRepository.getPosts();
      emit(PostsLoadSuccess(posts: posts));
    } on Object catch (e) {
      log(e.toString());
      emit(PostsLoadError(posts: state.posts));
    }
  }

  Future<void> createPost({
    required Post post,
  }) async {
    emit(PostsCreateInProgress(posts: state.posts));
    try {
      final postToAdd = await postRepository.createPost(post: post);
      state.posts.add(postToAdd);

      emit(PostsCreateSuccess(postId: postToAdd.id!, posts: state.posts));
    } on Object catch (e) {
      log(e.toString());
      emit(PostsCreateError(posts: state.posts));
    }
  }

  Future<void> editPost({
    required Post post,
  }) async {
    emit(PostsEditInProgress(posts: state.posts));
    try {
      await postRepository.updatePost(post: post, id: post.id ?? 1);
      emit(PostsEditSuccess(postId: post.id ?? 1, posts: state.posts));
    } on Object catch (e) {
      log(e.toString());
      emit(PostsEditError(posts: state.posts));
    }
  }

  Future<void> deletePost({
    required int? postId,
    required int postIndex,
  }) async {
    emit(PostsDeleteInProgress(posts: state.posts, postId: postId!));
    try {
      await postRepository.deletePost(id: postId);
      state.posts.removeAt(postIndex);
      emit(PostsDeleteSuccess(postId: postId, posts: state.posts));
    } on Object catch (e) {
      log(e.toString());
      emit(PostsDeleteError(posts: state.posts, postId: postId));
    }
  }
}
