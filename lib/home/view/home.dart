import 'package:ams_lab7/create_post/view/create_post_screen.dart';
import 'package:ams_lab7/home/cubit/posts_cubit.dart';
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
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadSuccess) {
            final posts = state.posts;
            return ListView.separated(
              itemCount: 100,
              itemBuilder: (context, index) {
                final post = posts.elementAt(index);
                return PostListItem(post: post);
              },
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: Colors.black,
              ),
            );
          } else if (state is PostsLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
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
  const PostListItem({required this.post, super.key});

  final Post post;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: _editPost,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          const SlidableAction(
            onPressed: null,
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
    Navigator.push<void>(
      context,
      ManagePostPage.routeView(post: post),
    );
  }

  void _editPost(BuildContext context) {
    final postCubit = BlocProvider.of<PostsCubit>(context);
    Navigator.push<void>(
      context,
      ManagePostPage.routeEdit(postCubit: postCubit, post: post),
    );
  }
}
