// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:ams_lab7/home/cubit/posts_cubit.dart';
import 'package:ams_lab7/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.red.shade700),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.red.shade700,
        ),
      ),
      home: BlocProvider(
        create: (context) => PostsCubit(
          postRepository: RepositoryCollection.instance
              .retrieve<PostRepository>() as PostRepository,
        )..loadPosts(),
        child: const HomePage(),
      ),
    );
  }
}
