

import 'package:flutter/material.dart';
import 'package:flutter_practice_app/main_activity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEmailPre extends StatefulWidget {
  @override
  State<EditEmailPre> createState() => _EditEmailPreState();
}

class _EditEmailPreState extends State<EditEmailPre> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  List<String> emailList = [];
  List<String> passList = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

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
          'EditEmailPre',
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
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: border, 
              ),
            ),
            space,
            // signUP button
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _addItem(email.text, password.text);
                  Fluttertoast.showToast(msg: 'Chage Your id/password');
                  Get.to(MainActivity());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)))),
                child: Text('Save Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailList = prefs.getStringList('EmailList') ?? [];
      passList = prefs.getStringList('PasswordList') ?? [];
      email.text = emailList[0];
      password.text = passList[0];
    });
  }

  _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('EmailList', emailList);
    await prefs.setStringList('PasswordList', passList);
  }

  _addItem(String email, String password) {
    setState(() {
      emailList[0] = email;
      passList[0] = password;
      _saveItems();
    });
  }
}