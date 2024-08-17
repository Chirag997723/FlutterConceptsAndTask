import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChanel extends StatelessWidget {
  final chanel = MethodChannel('myFirstMethodChannel');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MethodChanel'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            sendToAndroid('sendSms');
          },
          label: Text('sendSms'),
          icon: Icon(Icons.sms),
        ),
      ),
    );
  }

  Future<void> sendToAndroid(String name) async {
    try {
      await chanel.invokeMethod('sendString', {"sendSms": name});
    } on Exception catch (e) {
      print(e);
    }
  }
}
