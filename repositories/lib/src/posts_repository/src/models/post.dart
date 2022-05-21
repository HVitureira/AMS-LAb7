import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  const Post({
    this.userId,
    this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int? userId;
  final int? id;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() {
    return 'Post - userId: $userId, id: $id, title: $title, body: $body.';
  }
}
