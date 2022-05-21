part of 'posts_cubit.dart';

@immutable
abstract class PostsState extends Equatable {
  const PostsState({required this.posts});
  final List<Post> posts;
  @override
  List<Object?> get props => [posts];
}

class PostsInitial extends PostsState {
  const PostsInitial({required super.posts});
}

class PostsLoadInProgress extends PostsState {
  const PostsLoadInProgress({required super.posts});
}

class PostsCreateInProgress extends PostsState {
  const PostsCreateInProgress({required super.posts});
}

class PostsCreateSuccess extends PostsState {
  const PostsCreateSuccess({required this.postId, required super.posts});
  final int postId;

  @override
  List<Object?> get props => [postId];
}

class PostsCreateError extends PostsState {
  const PostsCreateError({required super.posts});
}

class PostsEditInProgress extends PostsState {
  const PostsEditInProgress({required super.posts});
}

class PostsEditSuccess extends PostsState {
  const PostsEditSuccess({required this.postId, required super.posts});
  final int postId;

  @override
  List<Object?> get props => [postId];
}

class PostsEditError extends PostsState {
  const PostsEditError({required super.posts});
}

class PostsLoadSuccess extends PostsState {
  const PostsLoadSuccess({required super.posts});
}

class PostsLoadError extends PostsState {
  const PostsLoadError({required super.posts});
}

class PostsDeleteInProgress extends PostsState {
  const PostsDeleteInProgress({required super.posts, required this.postId});
  final int postId;

  @override
  List<Object?> get props => [postId];
}

class PostsDeleteSuccess extends PostsState {
  const PostsDeleteSuccess({required this.postId, required super.posts});
  final int postId;

  @override
  List<Object?> get props => [postId];
}

class PostsDeleteError extends PostsState {
  const PostsDeleteError({required this.postId, required super.posts});
  final int postId;

  @override
  List<Object?> get props => [postId];
}
