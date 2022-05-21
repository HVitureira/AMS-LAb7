import 'package:repositories/repositories.dart';
import 'package:retrofit/retrofit.dart';

part 'post_repository.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class PostRepository {
  factory PostRepository(Dio dio) = _PostRepository;

  @GET('/posts')
  Future<List<Post>> getPosts({
    @Query('userId') int? userId,
    @Query('userId') int? id,
  });

  @POST('/posts')
  Future<Post> createPost({@Body() required Post post});

  @PUT('/posts/{id}')
  Future<Post> updatePost({
    @Path() required int id,
    @Body() required Post post,
  });

  @DELETE('/posts/{id}')
  Future<void> deletePost({
    @Path() required int id,
  });
}
