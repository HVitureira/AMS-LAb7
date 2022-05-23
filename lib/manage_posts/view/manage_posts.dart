import 'package:ams_lab7/home/cubit/posts_cubit.dart';
import 'package:ams_lab7/utils/show_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

enum PostAction { create, edit, view }

class ManagePostPage extends StatefulWidget {
  const ManagePostPage._internal({
    required this.action,
    this.post,
    super.key,
  });

  static Route _route({
    required PostsCubit postCubit,
    Post? post,
    int? postIndex,
    required PostAction postAction,
  }) {
    return MaterialPageRoute<void>(
      builder: (context) {
        return BlocProvider.value(
          value: postCubit,
          child: ManagePostPage._internal(
            action: postAction,
            post: post,
          ),
        );
      },
    );
  }

  static Route routeCreate({
    required PostsCubit postCubit,
  }) {
    return _route(
      postCubit: postCubit,
      postAction: PostAction.create,
    );
  }

  static Route routeView({
    required PostsCubit postCubit,
    required Post post,
  }) {
    return _route(
      postCubit: postCubit,
      postAction: PostAction.view,
      post: post,
    );
  }

  static Route routeEdit({
    required PostsCubit postCubit,
    required Post post,
    required int postIndex,
  }) {
    return _route(
      postCubit: postCubit,
      post: post,
      postAction: PostAction.edit,
      postIndex: postIndex,
    );
  }

  final PostAction action;
  final Post? post;

  @override
  State<ManagePostPage> createState() => _ManagePostPageState();
}

class _ManagePostPageState extends State<ManagePostPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double userIdSliderVal = 1;

  bool get isView => widget.action == PostAction.view;
  bool get isEdit => widget.action == PostAction.edit;
  bool get isCreate => widget.action == PostAction.create;
  Post? get currentPost => widget.post;
  double get sliderValue =>
      isCreate || isEdit ? userIdSliderVal : currentPost!.userId!.toDouble();
  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController()
      ..text = ((isView || isEdit) ? currentPost?.title : '')!;
    bodyController = TextEditingController()
      ..text = ((isView || isEdit) ? currentPost?.body : '')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isView
          ? null
          : FloatingActionButton(
              onPressed: _submitForm,
              child: Icon(isEdit ? Icons.edit : Icons.save),
            ),
      appBar: AppBar(title: Text(_getPageTitle())),
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostsCreateSuccess) {
            showSnackbar(context, 'Post was created with id ${state.postId}!');
            Navigator.pop(context);
          } else if (state is PostsCreateError) {
            showSnackbar(context, 'Error trying to create a post!');
          } else if (state is PostsEditSuccess) {
            showSnackbar(context, 'Post was edited with id ${state.postId}!');
            Navigator.pop(context);
          } else if (state is PostsEditError) {
            showSnackbar(context, 'Error trying to edit the post!');
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
                                activeColor: Colors.red,
                                divisions: 10,
                                label: userIdSliderVal.toInt().toString(),
                                min: 1,
                                max: 10,
                                value: sliderValue,
                                onChanged: isView
                                    ? null
                                    : (value) {
                                        setState(() {
                                          userIdSliderVal = value;
                                        });
                                      },
                              ),
                            ),
                            Text(
                              sliderValue.toInt().toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          readOnly: isView,
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
                          readOnly: isView,
                          maxLines: 10,
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
      final post = Post(
        title: title,
        body: body,
        userId: userIdSliderVal.toInt(),
      );
      final postsCubit = BlocProvider.of<PostsCubit>(context);
      if (isEdit) {
        postsCubit.editPost(
          post: post,
        );
      } else {
        postsCubit.createPost(
          post: post,
        );
      }
    }
  }

  String _getPageTitle() {
    switch (widget.action) {
      case PostAction.create:
        return 'Create Post';
      case PostAction.edit:
        return 'Edit Post';
      case PostAction.view:
        return 'View Post';
    }
  }
}
