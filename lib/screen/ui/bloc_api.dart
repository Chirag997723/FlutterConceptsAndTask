
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/api/posts_bloc.dart';
import 'package:flutter_practice_app/bloc/api/posts_event.dart';
import 'package:flutter_practice_app/bloc/api/posts_state.dart';
import 'package:flutter_practice_app/bloc/login/login_bloc.dart';
import 'package:flutter_practice_app/bloc/login/login_state.dart';
import 'package:flutter_practice_app/bloc/users/users_bloc.dart';
import 'package:flutter_practice_app/bloc/users/users_state.dart';
import 'package:flutter_practice_app/utils/enums.dart';

class BlocApi extends StatefulWidget {
  @override
  State<BlocApi> createState() => _BlocApiState();
}

class _BlocApiState extends State<BlocApi> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BlocApi',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<PostsBloc, PostsStates>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case PostStatus.failure:
              return Text(state.message.toString());
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.postList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = state.postList[index];
                  return ListTile(
                    title: Text(item.title!),
                    leading: Icon(Icons.insert_emoticon),
                    subtitle: Text(index.toString()),
                  );
                },
              );
          }
        },
      ),
    );
  }
}

class BlocPara1 extends StatefulWidget {
  @override
  State<BlocPara1> createState() => _BlocApiState1();
}

class _BlocApiState1 extends State<BlocPara1> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(ParameterizedEvent1());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BlocApi2',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case PostStatus.failure:
              return Text(state.message.toString());
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.postList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = state.postList[index];
                  return ListTile(
                    title: Text(item.firstName!),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.avatar!),
                    ),
                    subtitle: Text(item.email!),
                  );
                },
              );
          }
        },
      ),
    );
  }
}

class BlocPara2 extends StatefulWidget {
  @override
  State<BlocPara2> createState() => _BlocApiState2();
}

class _BlocApiState2 extends State<BlocPara2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BlocApi2',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case PostStatus.failure:
              return Text(state.message.toString());
            case PostStatus.success:
              return ListTile(
                title: Text(state.token),
              );
          }
        },
      ),
    );
  }
}
