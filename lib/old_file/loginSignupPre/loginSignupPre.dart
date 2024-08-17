import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/api/posts_event.dart';
import 'package:flutter_practice_app/bloc/login/login_bloc.dart';
import 'package:flutter_practice_app/old_file/loginSignupPre/signUpForm.dart';
import 'package:flutter_practice_app/main_activity.dart';
import 'package:flutter_practice_app/old_file/mvc_ex/api_repository.dart';
import 'package:flutter_practice_app/old_file/sqlite/sqLite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignupPre extends StatefulWidget {
  @override
  State<LoginSignupPre> createState() => _LoginSignupPreState();
}

class _LoginSignupPreState extends State<LoginSignupPre> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List<String> emailList = [];
  List<String> passList = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter valid emai',
                    hintText: 'Enter valid email id as abc@gmail.com'),
                controller: email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
                controller: password,
              ),
            ),
            SizedBox(
              height: 65,
              width: 300,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      // _login();
                      // checkLogin();
                      BlocProvider.of<LoginBloc>(context).add(
                      LoginEvent2(email: email.text, password: password.text));
                    },
                    label: Text(
                      'Log in ',
                      style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                    ),
                    icon: Icon(Icons.login),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New here ? '),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: InkWell(
                      onTap: () {
                        Get.to(SignupForm());
                      },
                      child: Text(
                        'Get Registered Now!!',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      )),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  final _dbHelper = DatabaseHelper.instance;

  void _login() async {
    final username = email.text;
    final passWord = password.text;

    final user = await _dbHelper.getUser(username, passWord);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful! Welcome ${user['username']}'),
      ));
      Get.to(MainActivity());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Signup now'),
      ));
    }
  }

  void checkLogin() async {
    final pre = await SharedPreferences.getInstance();
    bool emailCheck = false;

    for (var element in emailList) {
      if (element == email.text) {
        emailCheck = true;
      } else {
        emailCheck = false;
      }
    }
    if (emailList.isEmpty) {
      Fluttertoast.showToast(msg: 'Get Registered Now');
    } else {
      if (emailCheck) {
        if (passList.contains(password.text)) {
          pre.setBool('userLogin', true);
          Get.to(MainActivity());
        } else {
          Fluttertoast.showToast(msg: 'invalid password');
        }
      } else {
        Fluttertoast.showToast(msg: 'invalid email');
      }
    }
    print('1 --> $emailList');
    print('2 --> $passList');
  }
}
