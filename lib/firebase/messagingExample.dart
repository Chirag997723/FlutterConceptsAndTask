
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/firebase/for_sms/message.dart';
import 'package:flutter_practice_app/main.dart';

class MessagingExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messaging Example App',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => Application(),
        '/message': (context) => MessageView(),
      },
    );
  }
}

