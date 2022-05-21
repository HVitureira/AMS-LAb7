part of 'posts_cubit.dart';

@immutable
abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadInProgress extends PostsState {}

class PostsCreateInProgress extends PostsState {}

class PostsCreateSuccess extends PostsState {
  PostsCreateSuccess({required this.postId});
  final int postId;

  @override
  List<Object?> get props => [postId];
}

class PostsCreateError extends PostsState {}

class PostsEditInProgress extends PostsState {}

class PostsEditSuccess extends PostsState {
  PostsEditSuccess({required this.postId});
  final int postId;

  @override
  List<Object?> get props => [postId];
}

class PostsEditError extends PostsState {}

class PostsLoadSuccess extends PostsState {
  PostsLoadSuccess({required this.posts});
  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}

class PostsLoadError extends PostsState {}
