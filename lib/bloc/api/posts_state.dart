import 'package:equatable/equatable.dart';
import 'package:flutter_practice_app/old_file/model.dart';
import 'package:flutter_practice_app/utils/enums.dart';

class PostsStates extends Equatable {
  final PostStatus postStatus;
  final List<PostsModel> postList;
  final String message;

  const PostsStates({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostsModel>[],
    this.message = '',
  });

  @override
  List<Object> get props => [postStatus, postList, message];

  PostsStates copyWith({
    PostStatus? postStatus,
    List<PostsModel>? postList,
    String? message,
  }) {
    return PostsStates(
      message: message ?? this.message,
      postList: postList ?? this.postList,
      postStatus: postStatus ?? this.postStatus,
    );
  }
}
