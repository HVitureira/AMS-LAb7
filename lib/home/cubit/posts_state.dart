part of 'posts_cubit.dart';

@immutable
abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadInProgress extends PostsState {}

class PostsCreateInProgress extends PostsState {}

class PostsCreateSuccess extends PostsState {}

class PostsCreateError extends PostsState {}

class PostsLoadSuccess extends PostsState {
  PostsLoadSuccess({required this.posts});
  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}

class PostsLoadError extends PostsState {}
