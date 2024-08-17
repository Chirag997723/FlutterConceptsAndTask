import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GmailFirebase extends StatefulWidget {
  @override
  _GmailFirebaseState createState() => _GmailFirebaseState();
}

class _GmailFirebaseState extends State<GmailFirebase> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GmailSingIn'),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SignOutPage();
          } else {
            return LoginPage();
          }
        },)
    );
  }
}


class SignOutPage extends StatefulWidget{
  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${user?.email}'),
            ElevatedButton.icon(
              onPressed: () => signOut(),
              label: Text('signOut'))
          ],
        ),
      ),
    );
  }
  
signOut()async{
  await GoogleSignIn().signOut();
  await FirebaseAuth.instance.signOut();}
}

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(
        onPressed: () => login(), 
        child: Text('loginWithGmail')),),
    );
  }
  
  login() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
  
}
