import 'package:ams_lab7/create_post/view/create_post_screen.dart';
import 'package:ams_lab7/home/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts.elementAt(index).title),
                );
              },
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
    Navigator.push<void>(context, CreatePostPage.route(postCubit: postCubit));
  }
}
