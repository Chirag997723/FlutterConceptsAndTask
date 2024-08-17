import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/old_file/firebase/getOtpPage.dart';


class PhoneOtpFirebase extends StatefulWidget {
  @override
  _PhoneOtpFirebaseState createState() => _PhoneOtpFirebaseState();
}

class _PhoneOtpFirebaseState extends State<PhoneOtpFirebase> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage2();
          } else {
            return GetOtpPage();
          }
        },)
    );
  }
}