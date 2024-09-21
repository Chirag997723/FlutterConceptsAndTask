import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/api/posts_event.dart';
import 'package:flutter_practice_app/bloc/login/login_state.dart';
import 'package:flutter_practice_app/repository/api_repository.dart';
import 'package:flutter_practice_app/utils/enums.dart';

class LoginBloc extends Bloc<PostsEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEvent2>(_loginEvent2);
  }

  void _loginEvent2(LoginEvent2 event, Emitter<LoginState> emit) async {
    await parameterizedApi2(event.email, event.password).then(
      (value) {
        emit(state.copyWith(
            message: 'success', postStatus: PostStatus.success, token: value));
      },
    ).onError(
      (error, stackTrace) {
        print(error);
        print(stackTrace);
        emit(state.copyWith(
            message: error.toString(), postStatus: PostStatus.failure));
      },
    );
  }
}
