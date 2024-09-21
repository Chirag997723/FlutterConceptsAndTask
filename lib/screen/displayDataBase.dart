import 'package:flutter/material.dart';
import 'package:flutter_practice_app/helpers/sqLite.dart';

class displayDataBase extends StatefulWidget {
  @override
  State<displayDataBase> createState() => _displayDataBaseState();
}

class _displayDataBaseState extends State<displayDataBase> {
  final _dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _users = [];

  void _fetchUsers() async {
    List<Map<String, dynamic>> users = await _dbHelper.getAllUsers();
    setState(() {
      _users = users;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'displayDataBase',
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

      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _users.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(_users[index]['username'],style: TextStyle(fontSize: 18),),
              Spacer(),
              Text(_users[index]['password'],style: TextStyle(fontSize: 18),),
            ],
          );
        },
      ),
    );
  }
}
