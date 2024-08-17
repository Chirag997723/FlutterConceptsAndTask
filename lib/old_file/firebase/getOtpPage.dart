
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/old_file/editor/simple_example_app.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class GetOtpPage extends StatefulWidget{
  @override
  State<GetOtpPage> createState() => _GetOtpPageState();
}

class _GetOtpPageState extends State<GetOtpPage> {
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: phoneNumber,
              decoration: InputDecoration(
                prefix: Text('+91 '),
                prefixIcon: Icon(Icons.phone_rounded)
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => sendCode(),
              label: Text('Recieve Otp'))
          ],
        ),
      ),
    );
  }
  
  sendCode() async{
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91'+phoneNumber.text,
        verificationCompleted: (phoneAuthCredential) {
          
        }, verificationFailed: (error) {
          Get.snackbar('error occured1', error.code);
        }, codeSent: (verificationId, forceResendingToken) {
          Get.to(OtpPage(vid: verificationId));
        }, codeAutoRetrievalTimeout: (verificationId) {
          
        },);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error occured', e.code);
    } catch (e) {
      Get.snackbar('error occured', e.toString());
    }
  }
}

class HomePage2 extends StatefulWidget{
  @override
  State<HomePage2> createState() => _HomePage2State();
}

signOut()async{await FirebaseAuth.instance.signOut();}

class _HomePage2State extends State<HomePage2> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: user!.phoneNumber.toString());
    return Scaffold(
      body: Center(child: Text('${user!.phoneNumber}', style: TextStyle(fontSize: 20),),),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOut(),
        child: Icon(Icons.logout_outlined),),
    );
  }
}


class OtpPage extends StatefulWidget{
  final String vid;
  const OtpPage({super.key, required this.vid});
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var code = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OtpPage'),
      ),
      body: Center(
        child: Column(
          children: [
          textCode(),
          button(),
          ],
        ),
      ),
    );
  }
  
  textCode() {
    return Center(
      child: Pinput(
        length: 6,
        onChanged: (value) {
          setState(() {
            code=value;
          });
        },
      ),
    );
  }
  
  button() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
        signIn();
      }, child: Text('verify')),
    );
  }
  
  void signIn() async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.vid, smsCode: code);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        Get.offAll(AudioList());
      },);
    }on FirebaseAuthException catch (e) {
      Get.snackbar('error', e.code);
    } catch(e){
      Get.snackbar('error', e.toString());
    }
  }
}
