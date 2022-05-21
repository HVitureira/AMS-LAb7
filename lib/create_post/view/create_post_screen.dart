import 'package:ams_lab7/home/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostPage extends StatefulWidget {
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
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double userIdSliderVal = 1;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(title: const Text('Create Post')),
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostsCreateSuccess) {
            _showSnackbar('Post was created with id ${state.postId}!');
            Navigator.pop(context);
          } else if (state is PostsCreateError) {
            _showSnackbar('Error trying to create a post!');
          }
        },
        builder: (context, state) {
          if (state is PostsCreateInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('User ID:'),
                            Expanded(
                              child: Slider(
                                divisions: 10,
                                label: userIdSliderVal.toInt().toString(),
                                min: 1,
                                max: 10,
                                value: userIdSliderVal,
                                onChanged: (value) {
                                  setState(() {
                                    userIdSliderVal = value;
                                  });
                                },
                              ),
                            ),
                            Text(
                              userIdSliderVal.toInt().toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: titleController,
                          maxLength: 100,
                          decoration: const InputDecoration(labelText: 'Title'),
                          onSaved: (String? value) {
                            print("Value: '$value'");
                          },
                          validator: (String? value) {
                            if (value?.isEmpty ?? false) {
                              return 'Insert a Title.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: bodyController,
                          decoration: const InputDecoration(labelText: 'Body'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      final title = titleController.text;
      final body = bodyController.text;
      BlocProvider.of<PostsCubit>(context).createPost(
        postTitle: title,
        postBody: body,
        userId: userIdSliderVal.toInt(),
      );
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
        ),
      );
  }
}
