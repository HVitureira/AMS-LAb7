import 'package:ams_lab7/home/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage._internal({super.key});

  static Route route({required PostsCubit postCubit}) {
    return MaterialPageRoute<void>(
      builder: (context) {
        return BlocProvider.value(
          value: postCubit,
          child: const CreatePostPage._internal(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [TextFormField()],
          ),
        ),
      ),
    );
  }

  void _createPost() {}
}
