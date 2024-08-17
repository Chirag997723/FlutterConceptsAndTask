
import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable{
  const PostsEvent();
  @override
  List<Object> get props => [];
}

class PostFetched extends PostsEvent{}

class ParameterizedEvent1 extends PostsEvent{}

class LoginEvent2 extends PostsEvent{
  const LoginEvent2({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}