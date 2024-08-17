import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/api/posts_event.dart';
import 'package:flutter_practice_app/bloc/api/posts_state.dart';
import 'package:flutter_practice_app/old_file/mvc_ex/api_repository.dart';
import 'package:flutter_practice_app/utils/enums.dart';

class PostsBloc extends Bloc<PostsEvent, PostsStates> {
  PostsBloc() : super(const PostsStates()) {
    on<PostFetched>(_fetchPost);
  }

  void _fetchPost(PostFetched event, Emitter<PostsStates> emit) async {
    await fetchPostData().then(
      (value) {
        emit(state.copyWith(
            postStatus: PostStatus.success,
            message: 'success',
            postList: value));
      },
    ).onError(
      (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(state.copyWith(
            postStatus: PostStatus.failure, message: error.toString()));
      },
    );
  }

}
