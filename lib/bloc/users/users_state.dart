
import 'package:equatable/equatable.dart';
import 'package:flutter_practice_app/old_file/model.dart';
import 'package:flutter_practice_app/utils/enums.dart';

class UsersState extends Equatable {
  final PostStatus postStatus;
  final List<Data> postList;
  final String message;

  const UsersState({
    this.postStatus = PostStatus.loading,
    this.postList = const <Data>[],
    this.message = '',
  });

  @override
  List<Object> get props => [postStatus, postList, message];

  UsersState copyWith({
    PostStatus? postStatus,
    List<Data>? postList,
    String? message,
  }) {
    return UsersState(
      message: message ?? this.message,
      postList: postList ?? this.postList,
      postStatus: postStatus ?? this.postStatus,
    );
  }
}