import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/api/posts_event.dart';
import 'package:flutter_practice_app/bloc/login/login_bloc.dart';
import 'package:flutter_practice_app/screen/loginSignupPre/loginSignupPre.dart';
import 'package:flutter_practice_app/screen/main_activity.dart';
import 'package:flutter_practice_app/helpers/sqLite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = false;
  List<String> emailList = [];
  List<String> passList = [];
  final _dbHelper = DatabaseHelper.instance;

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    var space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SignupForm',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            space,
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Email',
                  border: border),
              keyboardType: TextInputType.emailAddress,
            ),

            space,

            // password
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: border,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              obscureText: !_obscureText,
            ),
            space,
            // confirm passwords
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: border,
              ),
              obscureText: true,
              validator: (value) {
                if (value != password.text) {
                  return 'password not match';
                }
                return null;
              },
            ),
            space,

            // signUP button
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  _signup();
                  Get.to(MainActivity());
                  // final pre = await SharedPreferences.getInstance();
                  // if (emailList.isEmpty) {
                  //   pre.setBool('userLogin', true);
                  //   _addItem(email.text, password.text);
                  //   Get.to(MainActivity());
                  // } else {
                  //   for (var element in emailList) {
                  //     if (element == email.text) {
                  //       Fluttertoast.showToast(msg: 'you are already signup');
                  //     } else {
                  //       pre.setBool('userLogin', true);
                  //       _addItem(email.text, password.text);
                  //       Get.to(MainActivity());
                  //     }
                  //   }
                  // }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)))),
                child: Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signup() async {
    final username = email.text;
    final passWord = password.text;

    await _dbHelper.createUser({'username': username, 'password': passWord});

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Signup successful! Please log in.'),
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailList = prefs.getStringList('EmailList') ?? [];
      passList = prefs.getStringList('PasswordList') ?? [];
    });
  }

  _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('EmailList', emailList);
    await prefs.setStringList('PasswordList', passList);
  }

  _addItem(String email, String password) {
    setState(() {
      emailList.add(email);
      passList.add(password);
      _saveItems();
    });
  }
}
