import 'package:dio/dio.dart';
import 'package:repositories/src/archiver.dart';
import 'package:repositories/src/posts_repository/post_repository.dart';
import 'package:repositories/src/repository_archive.dart';

class RepositoryCollection {
  static final instance = RepositoryArchive.instance;

  Archiver init() {
    final httpClient = Dio();

    return instance
      ..archive(
        Entry<PostRepository>(
          builder: () => PostRepository(httpClient),
        ),
      );
  }
}
