import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/api/posts_event.dart';
import 'package:flutter_practice_app/bloc/users/users_state.dart';
import 'package:flutter_practice_app/repository/api_repository.dart';
import 'package:flutter_practice_app/utils/enums.dart';

class UsersBloc extends Bloc<PostsEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<ParameterizedEvent1>(_parameterizedEvent1);
  }

  void _parameterizedEvent1(PostsEvent event, Emitter<UsersState> emit) async {
    await parameterizedApi().then(
      (value) {
        emit(state.copyWith(
          message: 'success',
          postList: value!.data,
          postStatus: PostStatus.success,
        ));
      },
    ).onError(
      (error, stackTrace) {
        emit(state.copyWith(
            postStatus: PostStatus.failure, message: error.toString()));
      },
    );
  }
}
