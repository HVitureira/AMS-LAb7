import 'package:ams_lab7/home/cubit/posts_cubit.dart';
import 'package:ams_lab7/manage_posts/view/manage_posts.dart';
import 'package:ams_lab7/utils/show_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:repositories/repositories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateScreen(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostsDeleteInProgress) {
            showSnackbar(context, 'Deleting post with id ${state.postId}...');
          } else if (state is PostsDeleteSuccess) {
            showSnackbar(
              context,
              'Post with id ${state.postId} was deleted!',
            );
          } else if (state is PostsDeleteError) {
            showSnackbar(
              context,
              'Error trying to delete the post  with id ${state.postId}!',
            );
          }
        },
        builder: (context, state) {
          if (state is PostsLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final posts = state.posts;
          return ListView.separated(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts.elementAt(index);
              return PostListItem(
                post: post,
                postIndex: index,
                key: UniqueKey(),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }

  void _openCreateScreen(BuildContext context) {
    final postCubit = BlocProvider.of<PostsCubit>(context);
    Navigator.push<void>(
      context,
      ManagePostPage.routeCreate(postCubit: postCubit),
    );
  }
}

class PostListItem extends StatelessWidget {
  const PostListItem({
    required this.post,
    required this.postIndex,
    super.key,
  });

  final Post post;
  final int postIndex;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => _deletePost(context, post.id, postIndex),
        ),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: _editPost,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) => _deletePost(context, post.id, postIndex),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: InkWell(
        onTap: () => _openViewScreen(context, post),
        child: ListTile(
          trailing: const Icon(Icons.chevron_right),
          title: Text(post.title),
        ),
      ),
    );
  }

  void _openViewScreen(BuildContext context, Post post) {
    final postCubit = BlocProvider.of<PostsCubit>(context);

    Navigator.push<void>(
      context,
      ManagePostPage.routeView(post: post, postCubit: postCubit),
    );
  }

  void _editPost(BuildContext context) {
    final postCubit = BlocProvider.of<PostsCubit>(context);
    Navigator.push<void>(
      context,
      ManagePostPage.routeEdit(
        postCubit: postCubit,
        post: post,
        postIndex: postIndex,
      ),
    );
  }

  void _deletePost(BuildContext context, int? postId, int postIndex) {
    final postCubit = BlocProvider.of<PostsCubit>(context);

    postCubit.deletePost(postId: postId, postIndex: postIndex);
  }
}
