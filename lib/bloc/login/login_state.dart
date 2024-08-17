import 'package:equatable/equatable.dart';
import 'package:flutter_practice_app/utils/enums.dart';

class LoginState extends Equatable {
  const LoginState({
    this.postStatus = PostStatus.loading,
    this.message = '',
    this.token = '',
  });

  final String token;
  final PostStatus postStatus;
  final String message;

  @override
  List<Object> get props => [token, message, postStatus];

  LoginState copyWith(
      {String? token,
      PostStatus? postStatus,
      String? message}) {
    return LoginState(
      token: token ?? this.token,
      message: message ?? this.message,
      postStatus: postStatus ?? this.postStatus,
    );
  }
}
